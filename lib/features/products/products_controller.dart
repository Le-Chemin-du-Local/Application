import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/products_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsControllerProvider = StateNotifierProvider<ProductsConstroller, ProductsState>((ref) {
  return ProductsConstroller(
    const ProductsState(products: AsyncValue.loading())
  );
});

class ProductsConstroller extends StateNotifier<ProductsState> {
  ProductsConstroller(ProductsState state) : super(state);

  Future loadData({String? authenticationHeader, bool refresh = false}) async {
    if (state.products.asData != null && !refresh) return;

    state = state.copyWith(products: const AsyncValue.loading());

    List<Product> productsToPut = const [
      Product(name: "Bière blonde", categories: ["Bières & cidres"], description: "Une super bière blonde", price: 12.0, isBreton: true),
      Product(name: "Bière ambrée", categories: ["Bières & cidres"], description: "Une super bière ambrée", price: 10.24, isBreton:  true),
      Product(name: "Carrotte", categories: ["Fruits"], description: "Peut-être que je suis dans la mauvaise catégorie...", price: 2.16, isBreton: false)
    ];

    state = state.copyWith(products: AsyncValue.data(productsToPut));
  }

}