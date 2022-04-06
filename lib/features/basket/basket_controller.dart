import 'package:chemin_du_local/features/basket/basket.dart';
import 'package:chemin_du_local/features/basket/basket_commerce.dart';
import 'package:chemin_du_local/features/basket/basket_product.dart';
import 'package:chemin_du_local/features/basket/basket_state.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final basketControllerProvider = StateNotifierProvider<BasketController, BasketState>((ref) {
  return BasketController(
    const BasketState(
      basket: AsyncValue.loading()
    )
  );
});

class BasketController extends StateController<BasketState> {
  BasketController(BasketState state) : super(state);

  Future updateBasketCommerce(BasketCommerce updated) async {
    final List<BasketCommerce>? currentCommerces = state.basket.value?.commerces;

    if (currentCommerces == null) return;

    state = state.copyWith(
      basket: AsyncValue.data(
        Basket(
          commerces: [
            for (final commerce in currentCommerces)
              if (commerce.commerce.id == updated.commerce.id) 
                updated
              else 
                commerce
          ] 
        )
      )
    );
  }

  Future addBasketCommerce(BasketCommerce toAdd) async {
    final List<BasketCommerce>? currentCommerces = state.basket.value?.commerces;

    if (currentCommerces == null) return;

    state = state.copyWith(
      basket: AsyncValue.data(
        Basket(
          commerces: [
            ...currentCommerces,
            toAdd
          ] 
        )
      )
    );
  }

  Future syncBasket(GraphQLClient? client) async {
    try {
      final basket = await _getBasketFromDisk();

      state = state.copyWith(
        basket: AsyncValue.data(basket)
      );
    } 
    on Exception catch(e) {
      state = state.copyWith(
        basket: AsyncValue.error(e)
      );
    }
  }

  Future<Basket> _getBasketFromDisk() async {
    return const Basket(
      commerces: [
        BasketCommerce(
          commerce: Commerce("6241fc008c8a112094e0ffea", name: "La Bizhhh"),
          products: [
            BasketProduct(
              product: Product("6245c3d295477883aecf93b1", name: "Bière blonde"),
              quantity: 2
            ),
            BasketProduct(
              product: Product("6245c3d295477883aecf93b2", name: "Bière ambrée"),
              quantity: 1
            )
          ]
        )
      ]
    );
  }
}