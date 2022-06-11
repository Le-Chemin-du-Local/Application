import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_quantity_picker.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:chemin_du_local/features/basket/models/basket_product/basket_product.dart';
import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketProductCard extends ConsumerWidget {
  const BasketProductCard({
    Key? key,
    required this.commerce,
    required this.product,
  }) : super(key: key);

  final BasketProduct product;
  final BasketCommerce commerce;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: ScreenHelper.instance.horizontalPadding
      ),
      child: Row(
        children: [
          // L'image
          SizedBox(
            width: 86, height: 86,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "$kImagesBaseUrl/products/${product.product.id ?? ""}.jpg",
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                  ),
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, size: 92, color: Theme.of(context).colorScheme.outline,);
                },
              )
            ),
          ),
          const SizedBox(width: 20,),

          // Le conteneur
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Le titre
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(product.product.name, style: Theme.of(context).textTheme.headlineSmall,),
                      ),

                      ElevatedButton(
                        onPressed: () => _removeProduct(ref), 
                        child: const Text("Supprimer", style: TextStyle(fontSize: 12),),
                      )
                    ],
                  ),
                ),

                // Le prix
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w500
                            ),
                            text: "${product.product.price}€",
                            children: [
                              TextSpan(
                                style: Theme.of(context).textTheme.bodyMedium,
                                text: " /${product.product.unit}",
                              )
                            ]
                          ),
                        ),
                      ),

                      ClQuantityPicker(
                        currentValue: product.quantity,
                        minValue: 1,
                        onChanged: (value) => _updateProductQuantity(ref, value),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _updateProductQuantity(WidgetRef ref, int quantity) async {
    ref.read(basketControllerProvider.notifier).updateBasketCommerce(
      commerce.copyWith(
        products: [
          for (final basketProduct in commerce.products)
            if (basketProduct.product.id == product.product.id)
              product.copyWith(quantity: quantity)
            else 
              basketProduct
        ]
      )
    );
  }

  Future _removeProduct(WidgetRef ref) async {
    ref.read(basketControllerProvider.notifier).updateBasketCommerce(
      commerce.copyWith(
        products: [
          for (final basketProduct in commerce.products)
            if (basketProduct.product.id != product.product.id)
              basketProduct
        ]
      )
    );
  }
}