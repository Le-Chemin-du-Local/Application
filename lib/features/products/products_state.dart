import 'package:chemin_du_local/features/products/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class ProductsState {
  const ProductsState({
    required this.products
  });

  final AsyncValue<List<Product>> products;

  AsyncValue<List<String>> get categories => products.when(
    data: (products) {
      final List<String> result = [];

      for (final product in products) {
        if (!result.contains(product.category)) result.add(product.category);
      }

      return AsyncValue.data(result);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace: stackTrace) 
  );

  AsyncValue<List<Product>> productsByCategory(String category) => products.when(
    data: (products) => AsyncValue.data([
      for (final product in products) 
        if (product.category == category)
          product
    ]),
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace: stackTrace)
  );

  ProductsState copyWith({
    AsyncValue<List<Product>>? products
  }) {
    return ProductsState(products: products ?? this.products);
  }
}