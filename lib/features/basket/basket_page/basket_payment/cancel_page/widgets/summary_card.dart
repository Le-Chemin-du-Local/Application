import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:chemin_du_local/features/commerces/commerces_graphql.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    Key? key,
    required this.basket
  }) : super(key: key);

  final Basket basket;

  QueryOptions _getCommerceInfoOptions(String commerceID) {
    return QueryOptions<dynamic>(
      document: gql(qCommerceMini),
      fetchPolicy: FetchPolicy.cacheOnly,
      variables: <String, dynamic>{
        "id": commerceID,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Résumé de votre commande", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w500
          ),),

          for (final basketCommerce in basket.commerces)
            _buildCommerce(context, basketCommerce)
        ],
      ),
    );
  }

  Widget _buildCommerce(BuildContext context, BasketCommerce basketCommerce) {
    return Query<dynamic>(
      options: _getCommerceInfoOptions(basketCommerce.commerceID),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (result.hasException) {
          return const ClStatusMessage(
            message: "Impossible de charger les informations du commerce",
          );
        }

        final Commerce commerce = Commerce.fromJson(result.data!["commerce"] as Map<String, dynamic>);
        final pickupDateString = basketCommerce.pickupDate != null
          ? "${DateFormat("dd/MM/yyyy").format(basketCommerce.pickupDate!)} -> ${DateFormat("hh:mm").format(basketCommerce.pickupDate!)} - ${DateFormat("hh:mm").format(basketCommerce.pickupDate!.add(const Duration(minutes: 30)))}"
          : "Inconnue";

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Le nom du commerce
            Flexible(
              child: Text(
                commerce.name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 4,),

            // La date de collecte
            Flexible(
              child: Text(
                "Collecte : $pickupDateString"
              ),
            ),
            const SizedBox(height: 3,),

            // Les produits
            for (final basketProduct in basketCommerce.products) ...{
              Row(
                children: [
                  Expanded(
                    child: Text(basketProduct.product.name, style: const TextStyle(fontWeight: FontWeight.w500),),
                  ),
                  const SizedBox(width: 3,),

                  Text("x${basketProduct.quantity}", style: const TextStyle(fontWeight: FontWeight.w500),)
                ],
              ),
              const SizedBox(height: 8,),
            },
            
            // Les paniers
            for (final panier in basketCommerce.paniers) ...{
              Text(panier.name, style: const TextStyle(fontWeight: FontWeight.w500),),
              const SizedBox(height: 3,),
            }
          ],
        );

      },
    );
  }
}