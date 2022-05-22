import 'dart:convert';

import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:chemin_du_local/features/basket/riverpod/basket_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

final basketControllerProvider = StateNotifierProvider<BasketController, BasketState>((ref) {
  return BasketController(
    const BasketState(
      basket: AsyncValue.loading()
    )
  );
});

class BasketController extends StateController<BasketState> {
  BasketController(BasketState state) : super(state);

  Future reset() async {
    const Basket newBasket = Basket(
      commerces: [] 
    );

    await _saveBasket(newBasket);
    state = state.copyWith(
      basket: const AsyncValue.data(newBasket)
    );
  }

  Future updateBasketCommerce(BasketCommerce updated) async {
    final List<BasketCommerce>? currentCommerces = state.basket.value?.commerces;

    if (currentCommerces == null) return;

    final Basket newBasket = Basket(
      commerces: [
        for (final commerce in currentCommerces)
          if (commerce.commerce.id == updated.commerce.id) 
            updated
          else 
            commerce
      ] 
    );

    await _saveBasket(newBasket);
    state = state.copyWith(
      basket: AsyncValue.data(newBasket)
    );
  }

  Future addBasketCommerce(BasketCommerce toAdd) async {
    final List<BasketCommerce>? currentCommerces = state.basket.value?.commerces;

    if (currentCommerces == null) return;

    final Basket newBasket = Basket(
      commerces: [
        ...currentCommerces,
        toAdd
      ] 
    );

    await _saveBasket(newBasket);
    state = state.copyWith(
      basket: AsyncValue.data(newBasket)
    );
  }

  Future updateSchedule(String commerceID, DateTime schedule) async {
    final List<BasketCommerce>? currentCommerces = state.basket.value?.commerces;
    if (currentCommerces == null) return;

    final Basket newBasket = Basket(
      commerces: [
        for (final commerce in currentCommerces)
          if (commerce.commerce.id == commerceID) 
            commerce.copyWith(
              pickupDate: schedule
            )
          else 
            commerce
      ] 
    );

    await _saveBasket(newBasket);
    state = state.copyWith(
      basket: AsyncValue.data(newBasket)
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
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final String? basketJson = preferences.getString("disk_basket");
    final Basket basket = basketJson != null 
      ? Basket.fromJson(jsonDecode(basketJson) as Map<String, dynamic>)
      : const Basket(commerces: []);

    return basket;
  }

  Future _saveBasket(Basket newBasket) async {
    await _saveBasketToDisk(newBasket);
  }

  Future _saveBasketToDisk(Basket newBasket) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString("disk_basket", jsonEncode(newBasket.toJson()));
  }
}