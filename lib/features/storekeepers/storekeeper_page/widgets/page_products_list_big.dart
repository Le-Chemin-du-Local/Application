import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:chemin_du_local/features/basket/models/basket_product/basket_product.dart';
import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_page/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PageProductsListBig extends ConsumerWidget {
 const PageProductsListBig({
    Key? key,
    required this.enableButton,
    required this.products,
    required this.commerce,
    required this.availableForClickAndCollect,
  }) : super(key: key);

  final bool enableButton;

  final Commerce? commerce;

  final List<Product> products;
  final List<String> availableForClickAndCollect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     return ref.watch(basketControllerProvider).basket.when(
      data: (data) => _buildContent(ref, data),
      loading: () => const Center(child: CircularProgressIndicator(),),
      error: (error, stackTrace) => const Align(
        alignment: Alignment.topCenter,
        child: ClStatusMessage(
          message: "Quelque chose c'est mal passé...",
        ),
      )
    );
  }

  Widget _buildContent(WidgetRef ref, Basket basket) {
    final BasketCommerce? basketCommerce = _commerceForID(basket, commerce?.id ?? "");

    final List<Widget> content = [
      if (products.isEmpty) 
        for (int i = 0; i < 4; ++i) 
          ClCard(child: Container())
      else 
        for (final product in products) 
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300, maxWidth: 200),
            child: ProductCard(
            product: product,
            showQuantityPicker: availableForClickAndCollect.contains(product.id),
            quantity: _productForID(basketCommerce, product.id ?? "")?.quantity ?? 0,
            onQuantityUpdated: (value) => _updateProductOnBasket(ref, product, value),
          )
      )
    ];

    return Opacity(
      opacity: products.isEmpty ? 0.4 : 1.0,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 270,
                  mainAxisExtent: 273,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16
                ),
                shrinkWrap: true,
                primary: false,
                children: content,
              ),
              const SizedBox(height: 12,),
    
              // The view products button
              Center(
                child: ClElevatedButton(
                  onPressed: () {
                    if (!enableButton) return;
                  },
                  child: const Text("Voir tous les produits"),
                ),
              ),
            ],
          ),
          if (products.isEmpty)
            const Positioned(
              top: 0, bottom: 0, left: 0, right: 0,
              child: Center(
                child: Text("Vous n'avez pas de produts ! Créez des fiches dans Mes produits"),
              )
            )
        ],
      ),
    );
  }

  Future _updateProductOnBasket(WidgetRef ref, Product updated, int quantity) async {
    if (commerce == null) return;

    final BasketCommerce basketCommerce = _commerceForID(ref.read(basketControllerProvider).basket.value, commerce!.id!) ?? BasketCommerce(
      commerce: commerce!,
      products: const []
    );

    final List<BasketProduct> basketProducts = basketCommerce.products;

    // Premier cas, on ajoute le produit
    if (quantity >= 1) {
      await ref.read(basketControllerProvider.notifier).updateBasketCommerce(
        basketCommerce.copyWith(
          products: [
            for (final product in basketProducts)
              if (product.product.id == updated.id) 
                BasketProduct(quantity: quantity, product: updated)
              else 
                product
          ]
        )
      );
    }
    
    if (quantity == 1 && _commerceForID(ref.read(basketControllerProvider).basket.value, commerce!.id!) == null) {
      await ref.read(basketControllerProvider.notifier).addBasketCommerce(
        BasketCommerce(
          commerce: commerce!,
          products: [
            BasketProduct(product: updated, quantity: quantity)
          ]
        )
      );
    }
    else if (quantity == 1 && (_productForID(basketCommerce, updated.id ?? "") == null)) { // Second cas, on ajoute le produit 
      await ref.read(basketControllerProvider.notifier).updateBasketCommerce(
        basketCommerce.copyWith(
          products: [
            ...basketProducts,
            BasketProduct(product: updated, quantity: quantity)
          ]
        )
      );
    }
    else if (quantity == 0) {
      await ref.read(basketControllerProvider.notifier).updateBasketCommerce(
        basketCommerce.copyWith(
          products: [
            for (final product in basketProducts)
              if (product.product.id != updated.id) 
                product
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

  BasketProduct? _productForID(BasketCommerce? commerce, String id) {
    if (commerce == null) return null;

    for (final product in commerce.products) {
      if (product.product.id == id) return product;
    }

    return null;
  }
}