import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_quantity_picker.dart';
import 'package:chemin_du_local/features/basket/models/basket_product/basket_product.dart';
import 'package:flutter/material.dart';

class BasketProductCard extends StatelessWidget {
  const BasketProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final BasketProduct product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: ScreenHelper.horizontalPadding
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

          // Le contenye
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Le titre
                Flexible(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(product.product.name, style: Theme.of(context).textTheme.headline2,),
                      ),

                      IconButton(
                        onPressed: () {}, 
                        iconSize: 18,
                        splashRadius: 12,
                        icon: const Icon(Icons.delete_outline)
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
                            style: Theme.of(context).textTheme.headline2!.copyWith(
                              color: Theme.of(context).colorScheme.primary
                            ),
                            text: "${product.product.price}€",
                            children: [
                              TextSpan(
                                style: Theme.of(context).textTheme.bodyText2,
                                text: " /${product.product.unit}",
                              )
                            ]
                          ),
                        ),
                      ),

                      ClQuantityPicker(
                        currentValue: product.quantity,
                        onChanged: (value) {},
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
}