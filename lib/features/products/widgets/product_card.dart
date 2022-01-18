import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(color: Palette.colorWhite),
      textAlign: TextAlign.center,
      child: ClCard(
        padding: EdgeInsets.zero,
        backgroundColor: Theme.of(context).primaryColor, 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The image of the product
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset("assets/images/beer.png", fit: BoxFit.cover,),
              )
            ),
            const SizedBox(height: 8.0,),
            // The name of the product
            Flexible(child: Text(product.name)),
            const SizedBox(height: 4.0,),
            // The price
            Flexible(child: Text("${product.price}€"))
          ],
        ),
      ),
    );
  }
}