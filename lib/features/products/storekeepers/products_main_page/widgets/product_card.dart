import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_quantity_picker.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    this.quantity = 0,
    this.borderColor,
    this.showQuantityPicker = false,
    this.onQuantityUpdated,
  }) : super(key: key);

  final Product product;

  final Color? borderColor;
  final bool showQuantityPicker;

  final int quantity;
  final Function(int)? onQuantityUpdated;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      padding: const EdgeInsets.all(10),
      borderColor: borderColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The image of the product
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: _buildImageWithPrice(context),
            )
          ),
          const SizedBox(height: 8.0,),
          // The name of the product
          Flexible(child: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold),)),
          const SizedBox(height: 8.0,),


          // The flag if it's a breton product
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (product.isBreton ?? false)
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/images/drapeau_breton.png")
                    )
                  )
                else 
                  Container(),
                
                if (showQuantityPicker)
                  Flexible(
                    child: ClQuantityPicker(
                      minValue: 0,
                      currentValue: quantity,
                      onChanged: onQuantityUpdated,
                    ),
                  )
                else  
                  Container()
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildImageWithPrice(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            "$kImagesBaseUrl/products/${product.id ?? ""}.jpg",
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              ),
            ),
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image, size: 92, color: Theme.of(context).dividerColor,);
            },
          )
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0)
              )
            ),
            child: RichText(
              text: TextSpan(
                text: "${product.price}€",
                style: const TextStyle(color: Palette.colorWhite, fontWeight: FontWeight.w500),
                children: const [
                  TextSpan(text: "/pièce", style: TextStyle(fontSize: 12.0))
                ]
              ),
            ),
          ),
        )
      ],
    );
  }
}