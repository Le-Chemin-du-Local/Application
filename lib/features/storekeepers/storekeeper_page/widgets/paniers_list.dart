import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier/panier.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/panier_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PaniersList extends ConsumerWidget {
  const PaniersList({
    Key? key,
    required this.commerce,
  }) : super(key: key);

  final Commerce? commerce;

  QueryOptions _paniersQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qAllPaniers),
      variables: <String, dynamic>{
        "commerceID": commerce?.id
      }
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Headline
        const Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
            child: Text(
              "Sinon laissez vous tenter par nos paniers", 
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20,),

        // La liste des paniers
        if (commerce == null) 
          const ClStatusMessage(
            type: ClStatusMessageType.info,
            message: "Ce commerce ne propose pas encore de panier",
          )
        else 
          Flexible(
            child: Query<dynamic>(
              options: _paniersQueryOptions(),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                }
          
                if (result.hasException) {
                  return const ClStatusMessage(
                    message: "Nous ne parvenons pas à charger les paniers",
                  );
                }
          
                final List mapPaniers = result.data!["commerce"]["paniers"]["edges"] as List;
                final List<Panier> paniers = [];
          
                for (final mapPanier in mapPaniers) {
                  paniers.add(Panier.fromJson(mapPanier["node"] as Map<String, dynamic>));
                }

                return ref.watch(basketControllerProvider).basket.when(
                  data: (data) => _buildContent(ref, data, paniers: paniers),
                  loading: () => const Center(child: CircularProgressIndicator(),),
                  error: (error, stackTrace) => const Align(
                    alignment: Alignment.topCenter,
                    child: ClStatusMessage(
                      message: "Quelque chose c'est mal passé...",
                    ),
                  )
                );
              },
            ),
          )
      ],
    );
  }

  Widget _buildContent(WidgetRef ref, Basket basket, {
    required List<Panier> paniers,
  }) {
    return Opacity(
      opacity: paniers.isEmpty ? 0.4 : 1.0,
      child: Stack(
        children: [
          ListView(
            controller: ScrollController(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: ScreenHelper.horizontalPadding,),
              // S'il n'y a pas de paniers, on met un placeholder
              if (paniers.isEmpty) 
                for (int i = 0; i < 4; ++i)
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ClCard(
                        child: Container(),
                      ),
                    ),
                  )
              // Sinon, on met la liste des paniers
              else 
                for (final panier in paniers) 
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 720),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: PanierCard(
                        panier: panier.copyWith(
                          quantity: panier.quantity - _deductibleQuantity(basket, panier)
                        ),
                        onOpen: () => _addPanierOnBasket(ref, basket, panier),
                      ),
                    ),
                  )
            ],
          ),

          if (paniers.isEmpty)
            const Positioned(
              top: 0, bottom: 0, left: 0, right: 0,
              child: Center(
                child: Text("Vous n'avez pas créé de paniers ! Créez en un grâce au service Paniers"),
              ),
            )
        ],
      ),
    );
  }

  int _deductibleQuantity(Basket basket, Panier panierToUpdate) {
    final BasketCommerce? basketCommerce = _commerceForID(basket, commerce?.id ?? "");
    int result = 0;

    if (basketCommerce == null) return 0;

    for (final panier in basketCommerce.paniers) {
      if (panier.id == panierToUpdate.id) {
        ++result;
      }
    }

    return result;
  }

  Future _addPanierOnBasket(WidgetRef ref, Basket basket, Panier toAdd) async {
    if (commerce == null) return;

    final BasketCommerce? basketCommerce = _commerceForID(basket, commerce?.id ?? "");

    if (basketCommerce == null) {
      await ref.read(basketControllerProvider.notifier).addBasketCommerce(
        BasketCommerce(
          commerce: commerce!,
          paniers: [
            toAdd
          ]
        )
      );
    }
    else {
      await ref.read(basketControllerProvider.notifier).updateBasketCommerce(
        basketCommerce.copyWith(
          paniers: [
            ...basketCommerce.paniers,
            toAdd,
          ]
        )
      );
    }
  }

  BasketCommerce? _commerceForID(Basket? basket, String id) {
    if (basket == null) return null;

    for (final commerce in basket.commerces) {
      if (commerce.commerce.id == id) return commerce;
    }

    return null;
  }

}