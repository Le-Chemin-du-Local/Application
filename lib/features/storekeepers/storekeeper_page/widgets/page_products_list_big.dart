import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/product_card.dart';
import 'package:flutter/material.dart';

class PageProductsListBig extends StatelessWidget {
 const PageProductsListBig({
    Key? key,
    required this.enableButton,
    required this.products,
  }) : super(key: key);

  final bool enableButton;

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [
    for (final product in products) 
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300, maxWidth: 200),
        child: ProductCard(product: product)
      )
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GridView(
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
    );
  }
}