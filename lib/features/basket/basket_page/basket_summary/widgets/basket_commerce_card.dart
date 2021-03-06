import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_summary/widgets/basket_product_card.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:chemin_du_local/features/commerces/commerces_graphql.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BasketCommerceCard extends ConsumerWidget {
  const BasketCommerceCard({
    Key? key,
    required this.commerce
  }) : super(key: key);

  final BasketCommerce commerce;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le nom du commerce
        Container(
          color: Theme.of(context).colorScheme.secondaryContainer,
          padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
          height: 42,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Query<dynamic>(
                  options: QueryOptions<dynamic>(
                    document: gql(qCommerceMini),
                    variables: <String, dynamic>{
                      "id": commerce.commerceID
                    }
                  ),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.isLoading) {
                      return const LinearProgressIndicator();
                    }

                    if (result.hasException) {
                      Text(
                        "Nom inconnue...",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500
                        )
                      );
                    }
                    
                    final Commerce commerce = Commerce.fromJson(result.data!["commerce"] as Map<String, dynamic>);

                    return Text(
                      commerce.name,
                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w500
                      )
                    );
                  },
                )
              ),

              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: Center(
                  child: Text(
                    commerce.products.length.toString(),
                  )
                ),
              )
            ],
          ),
        ),
        // Les produits et paniers
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: ListView(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final product in commerce.products)
                  BasketProductCard(
                    commerce: commerce,
                    product: product, 
                  ),
                if (commerce.paniers.isNotEmpty)... {
                  const Divider(),

                  for (final panier in commerce.paniers) 
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: ScreenHelper.instance.horizontalPadding
                      ),
                      child: Text("Panier : ${panier.name}", style: Theme.of(context).textTheme.headlineSmall,),
                    )
                }
              ],
            ),
          ),
        )
      ],
    );
  }
}