import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:flutter/material.dart';

class PanierProductCard extends StatelessWidget {
  const PanierProductCard({
    Key? key,
    required this.product,
    required this.isSelected,
  }) : super(key: key);

  final Product product;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1.0 : 0.5,
      child: ClCard(
        padding: const EdgeInsets.all(10),
        borderColor: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
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
            if (product.isBreton ?? false)
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/images/drapeau_breton.png")
                )
              )
          ],
        ),
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
                style: const TextStyle(fontWeight: FontWeight.w500),
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