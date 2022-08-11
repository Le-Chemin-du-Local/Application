import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_basket_controller.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/service_info_card.dart';
import 'package:chemin_du_local/features/stripe/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tuple/tuple.dart';

class ServicesBasketPage extends ConsumerStatefulWidget {
  const ServicesBasketPage({
    Key? key,
    required this.commerceID
  }) : super(key: key);

  final String commerceID;

  @override
  ConsumerState<ServicesBasketPage> createState() => _ServicesBasketPageState();
}

class _ServicesBasketPageState extends ConsumerState<ServicesBasketPage> {
  final List<String> _serviceToDelete = []; 

  bool _isLoading = false;
  String _errorMessage = "";
  final CardEditController _cardController = CardEditController();

  MutationOptions _addServicesOption() {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateServices),
      onError: (error) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Votre carte à bien été prise, mais vos services n'ont pas pu être souscrits...";
        });
      },
      onCompleted: (dynamic data) {
        if (data == null) return;
        ref.read(servicesBasketControllerProvider.notifier).clear();
        Navigator.of(context).pop(true);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("Souscrire aux services"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final List<Widget> children = [
            // La liste des services à faire payer
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenHelper.instance.horizontalPadding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (final service in ref.watch(servicesBasketControllerProvider).services) ...{
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Transform.scale(
                                scale: 2,
                                child: Checkbox(
                                  value: !_serviceToDelete.contains(service.item1.id), 
                                  shape: const CircleBorder(),
                                  onChanged: (mustKeep) {
                                    if (!(mustKeep ?? false)) {
                                      setState(() {
                                        _serviceToDelete.add(service.item1.id);
                                      });
                                    }
                                    else {
                                      setState(() {
                                        _serviceToDelete.remove(service.item1.id);
                                      });
                                    }
                                  }
                                ),
                              ),
                              const SizedBox(width: 32,),
                        
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 236, maxWidth: 423),
                                child: ServiceInfoCard(
                                  serviceInfo: service.item1,
                                  initialServiceType: service.item2,
                                  buttonText: "En savoir plus",
                                  onButtonClick: () {},
                                  isSelected: !_serviceToDelete.contains(service.item1.id),
                                  onSelect: (value) {},
                                  forceHideBorder: true,
                                  onTypeChanged: (type) {
                                    ref.read(servicesBasketControllerProvider.notifier).replaceServiceInfoType(service.item1, type);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 12,),
                      }
                    ],
                  ),
                ),
              ),
            ),

            // Le formulaire de paiement
            Flexible(
              child: SingleChildScrollView(
                child: ClCard(
                  child: _isLoading ? const Center(child: CircularProgressIndicator(),) : Mutation<dynamic>(
                    options: _addServicesOption(),
                    builder: (runMutation, result) {
                      if (result?.isLoading ?? false) {
                        return const Center(child: CircularProgressIndicator(),);
                      }

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (_errorMessage.isNotEmpty) ...{
                            ClStatusMessage(
                              message: _errorMessage,
                            ),
                            const SizedBox(height: 12,),
                          },

                          Text(
                            "Rentrez votre moyen de paiement",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: 12,),
                          CardField(
                            controller: _cardController,
                            decoration: InputDecoration(
                              label: const Text("Votre carte"),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surface,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              contentPadding: const EdgeInsets.all(12),

                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.outline
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),

                          // Le bouton de souscription
                          const SizedBox(height: 16,),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: ElevatedButton.icon(
                              onPressed: () => _handleSubscription(runMutation), 
                              icon: const Icon(Icons.arrow_back),
                              label: const Text("Souscrire maintenant"),
                            ),
                          )
                        ],
                      );
                    }
                  ),
                ),
              ),
            )
          ];

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        },
      ),
    );
  }

  Future _handleSubscription(RunMutation? runMutation) async {
    bool paymentSuccess = await _handlePayment();
    final List<Tuple2<ServiceInfo, ServiceType>> servicesToAdd = ref.read(servicesBasketControllerProvider).services;

    if (paymentSuccess && runMutation != null) {
      runMutation(<String, dynamic>{
        "commerceID": widget.commerceID,
        "services": <Map<String, dynamic>>[
          for (final serviceToAdd in servicesToAdd)
            if (!_serviceToDelete.contains(serviceToAdd.item1.id))
              <String, dynamic>{
                "serviceID": "${serviceToAdd.item1.id}_${serviceToAdd.item2 == ServiceType.monthly ? "M" : "T"}",
                "updateType": "ADD"
              }
        ]
      });
    }
  }

  Future<bool> _handlePayment() async {
    if (!_cardController.complete) return false;

    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    final String? userToken = ref.read(appUserControllerProvider).token;

    if (userToken == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Vous n'auriez jamais du vous retrouver ici... Vous devez vous connecter avant de finaliser votre achat.";
      });
    }

    final String authHeader = "Bearer $userToken";

    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        )
      );

      final setupIntentResult = await StripeService.instance.handleSetupIntent(
        authorizationHeader: authHeader,
        isForCommerce: true,
        paymentMethodId: paymentMethod.id,
      );

      final String? clientSecret = setupIntentResult["clientSecret"] as String?;

      if (clientSecret != null) {
        await Stripe.instance.confirmSetupIntent(clientSecret, const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData()
        ));

        return true;
      }

      setState(() {
        _isLoading = false;
        _errorMessage = "L'authentication à échouer";
      });

      return false;
    }
    on Exception catch(e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Le paiement n'a pas put se faire... $e";
      });

      return false;
    }
  }
}