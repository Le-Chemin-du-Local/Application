import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PageProductsList extends StatelessWidget {
  const PageProductsList({
    Key? key,
    required this.enableButton,
    required this.products,
  }) : super(key: key);

  final bool enableButton;

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // La liste des produits
        Flexible(
          child: ListView(
            controller: ScrollController(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [
              for (final product in products) 
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: ProductCard(
                      product: product,
                    ),
                  ),
                )
            ],
          ),
        ),
        const SizedBox(height: 10,),

        // Le bouton
        Center(
          child: ClElevatedButton(
            onPressed: () {
              if (!enableButton) return;
            },
            child: const Text("Voir tous les produits"),
          ),
        )
      ],
    );
  }
}