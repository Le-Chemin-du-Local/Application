import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/all_services_page/all_services_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/remove_page/remove_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/widgets/due_balance.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/subscribe_page/subscribe_page.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

enum Tab { allServices, subscription, cancellation }

class ServicesPage extends StatefulWidget {
  const ServicesPage({
    Key? key,
    required this.onPageChanged,
    required this.onShowDrawer,
  }) : super(key: key);

  final Function(int) onPageChanged;
  final Function() onShowDrawer;

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  Tab _currentTab = Tab.allServices;

  QueryOptions _commerceServicesQueryOption() {
    return QueryOptions<dynamic>(
      document: gql(qGetServicesForStoreKeeper)
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentTab != Tab.allServices) {
          setState(() {
            _currentTab = Tab.allServices;
          });

          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: ClAppBar(
          onShowDrawer: widget.onShowDrawer,
          canPop: _currentTab != Tab.allServices,
          title: const Text("Mes services"),
        ),
        body: Query<dynamic>(
          options: _commerceServicesQueryOption(),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }
    
            if (result.hasException) {
              return const Align(
                alignment: Alignment.topCenter,
                child: ClStatusMessage(
                  message: "Nous n'arrivons pas à charger la liste de vos services...",
                ),
              );
            }
    
            final User user = User.fromJson(result.data!["user"] as Map<String, dynamic>);
    
            if (user.commerce == null) {
              return const Align(
                alignment: Alignment.topCenter,
                child: ClStatusMessage(
                  message: "Vous n'avez pas de commerce a qui attacher des services...",
                ),
              );
            }
    
            return _buildContent(context, commerce: user.commerce!, refetch: refetch);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, {
    required Commerce commerce,
    Refetch? refetch,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // La balance en cours
        if (commerce.services.isNotEmpty && commerce.lastBilledDate != null) ...{
          DueBalance(commerce: commerce,),
          const SizedBox(height: 12,),
        },

        // La page en cours
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenHelper.instance.horizontalPadding
            ),
            child: Builder(
              builder: (context) {
                if (_currentTab == Tab.subscription) {
                  return SubscribePage(
                    commerce: commerce, 
                    onCancel: () {
                      setState(() {
                        _currentTab = Tab.allServices;
                      });
                    }, 
                    onSuccess: () {
                      setState(() {
                        _currentTab = Tab.allServices;
                      });
                    }
                  );
                }

                if (_currentTab == Tab.cancellation) {
                  return RemovePage(
                    commerce: commerce,
                    subscribedServices: commerce.services,
                    onCancel: () {
                      setState(() {
                        _currentTab = Tab.allServices;
                      });
                    },
                    onSuccess: () {
                      if (refetch != null) {
                        refetch();
                      }
                      setState(() {
                        _currentTab = Tab.allServices;
                      });
                    },
                  );
                }
                return AllServicesPage(
                  commerce: commerce,
                  onCancel: () {
                    setState(() {
                      _currentTab = Tab.cancellation;
                    });
                  },
                  onSubscribe: () {
                    setState(() {
                      _currentTab = Tab.subscription;
                    });
                  },
                  shouldRefetch: () {
                    if (refetch != null) refetch();
                  },
                );
              },
            ),
          ),
        )
      ] 
    );
  }
}