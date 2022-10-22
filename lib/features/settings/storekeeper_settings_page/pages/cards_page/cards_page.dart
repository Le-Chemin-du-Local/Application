import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/settings/storekeeper_settings_page/pages/cards_page/widgets/card_card.dart';
import 'package:chemin_du_local/features/user/widgets/card_form.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({Key? key}) : super(key: key);

  QueryOptions _cardsOptions() {
    return QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(r'''
        query GetCommerceAddress {
          commerce {
            id
            name
            defaultPaymentMethod {
              name
              stripeID
              cardBrand
              cardLast4Digits 
            }
          }
        }
      ''')
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("Gérer mes moyens de paiements"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.instance.horizontalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // La liste des cartes
            Expanded(
              child: Query<dynamic>(
                options: _cardsOptions(),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  if (result.hasException) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: ClStatusMessage(
                        message: "Nous n'avons pas pu charger votre moyen de paiement...",
                      ),
                    );
                  }
                  
                  final Commerce commerce = Commerce.fromJson(result.data!["commerce"] as Map<String, dynamic>);
                  
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Le texte d'information
                        const Text("Ce moyen de paiement est utilisé pour tous vos services souscrits.Si vous le modifier, les prélèvements s’effectueront sur cette nouvelle carte."),
                        const SizedBox(height: 12,),

                        // La carte si elle existe
                        if (commerce.defaultPaymentMethod != null) ...{
                          CardCard(
                            paymentMethod: commerce.defaultPaymentMethod!,
                            onModify: () => _openCardForm(context, refetch, buttonText: "Modifier ma carte"),
                          ),
                          const SizedBox(height: 12,),
                        },

                        // Le bouton d'ajout
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: commerce.defaultPaymentMethod != null ? null : () => _openCardForm(context, refetch, buttonText: "Ajouter une carte"),
                            child: const Text("Ajouter une nouvelle carte"),
                          ),
                        ),
                        const SizedBox(height: 12,)
                      ],
                    ),
                  );
                }
              ),
            ),
            const SizedBox(height: 12,),

          ],
        ),
      ),
    );
  }

  Future _openCardForm(BuildContext context, Refetch? refetch, {
    required String buttonText,
  }) async {
    final String? paymentMethodId = await Navigator.of(context).push<String?>(
      MaterialPageRoute(
        builder: (context) => CardForm(payButtonText: buttonText, isFormCommerce: true,)
      )
    );

    if (paymentMethodId != null) {
      if (refetch != null) refetch();
    }
  }
}