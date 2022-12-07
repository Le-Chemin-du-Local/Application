import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/settings/storekeeper_settings_page/pages/address_page/address_page.dart';
import 'package:chemin_du_local/features/settings/storekeeper_settings_page/pages/bank_details_page/bank_details_page.dart';
import 'package:chemin_du_local/features/settings/storekeeper_settings_page/pages/cards_page/cards_page.dart';
import 'package:chemin_du_local/features/settings/storekeeper_settings_page/pages/commands_history_page/commands_history_page.dart';
import 'package:chemin_du_local/features/settings/storekeeper_settings_page/pages/default_page/default_page.dart';
import 'package:chemin_du_local/features/settings/widgets/setting_button.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class StoreKeeperSettingsPage extends StatelessWidget {
  const StoreKeeperSettingsPage({
    Key? key,
    required this.onShowDrawer
  }) : super(key: key);

  final Function() onShowDrawer;

  QueryOptions _storekeeperOptions() {
    return QueryOptions<dynamic>(
      document: gql(r'''
        query GetCommerceBalance {
          user {
            id,
            role,
            email,
            commerce {
              id
              name
              balance
              transferts {
                value
                ibanOwner
                iban
                bic
              }
            }
          }
        }
      '''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: false,
        onShowDrawer: onShowDrawer,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Query(
                options: _storekeeperOptions(), 
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(child: CircularProgressIndicator(),);
                  } 

                  if (result.hasException) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: ClStatusMessage(
                        message: "Nous n'arrivons malheuresement pas à charger votre balance",
                      ),
                    );
                  }

                  final User storeKeeper = User.fromJson(result.data!["user"] as Map<String, dynamic>);
                  final Commerce? commerce = storeKeeper.commerce;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenHelper.instance.horizontalPadding,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Le nom du commerce
                        Text(commerce?.name ?? "Nom inconnu", style: Theme.of(context).textTheme.headlineMedium,),
                        const SizedBox(height: 4,),

                        // La balance du commerce
                        Text(
                          "${(commerce?.balance ?? 0).toStringAsFixed(2)}€",
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary
                          ),
                        ),
                        Text(
                          "Solde actuel",
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary
                          ),
                        ),
                        const SizedBox(height: 4,),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              const TextSpan(
                                text: "Le prochain virement vers votre compte bancaire aura lieu le "
                              ),
                              TextSpan(
                                text: DateFormat("dd/MM/yyyy").format(DateTime.now().add(const Duration(days: 1))),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary
                                )
                              ),
                              const TextSpan(
                                text: ". Les virements sont effectués automatiquement tous les jours."
                              )
                            ]
                          ),
                        ),
                        const SizedBox(height: 16,)
                      ],
                    ),
                  );
                }
              ),
              Expanded(
                child: ListView(
                  children: [
                    const SettingButton(
                      icon: Icons.history,
                      title: "Historique des commandes", 
                      page: CommandsHistroyPage(),
                    ),

                    const SettingButton(
                      icon: Icons.history, 
                      title: "Historique des virements", 
                      page: DefaultPage()
                    ),

                    const SettingButton(
                      icon: Icons.history, 
                      title: "Historique des factures", 
                      page: DefaultPage()
                    ),

                    const SettingButton(
                      icon: Icons.location_on_outlined, 
                      title: "Gérer mon adresse", 
                      page: AddressPage()
                    ),

                    const SettingButton(
                      icon: Icons.account_balance,
                      title: "Gérer mes informations bancaire",
                      page: BankDetailsPage()
                    ),

                    const SettingButton(
                      icon: Icons.credit_card,
                      title: "Gérer mes moyens de paiement",
                      page: CardsPage(),
                    ),

                    const SettingButton(
                      icon: Icons.person_outline,
                      title: "Gérer mes informations",
                      page: DefaultPage(),
                    ),

                    const SettingButton(
                      icon: Icons.notifications_outlined,
                      title: "Gérer mes notifications",
                      page: DefaultPage(),
                    ),

                    const SettingButton(
                      icon: Icons.info_outline,
                      title: "À propos du Chemin du Local",
                      page: DefaultPage(),
                    ),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Supprimer mon compte",
                        style: TextStyle(
                          color: Palette.colorError,
                          decoration: TextDecoration.underline
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}