import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PageProductsList extends StatelessWidget {
  const PageProductsList({
    Key? key,
    required this.useBigLayout,
    required this.enableButton,
    required this.products,
  }) : super(key: key);

  final bool useBigLayout;
  final bool enableButton;

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final List<Widget> content = [
    for (final product in products) 
      ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300, maxWidth: 200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProductCard(product: product),
        )
      )
  ];

  return MultiSliver(
    children: <Widget>[
      if (useBigLayout)
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 270,
            mainAxisExtent: 273,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16
          ),
          delegate: SliverChildListDelegate(content),  
        )
      else 
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: content,
            ),
          ),
        ),
  
      // The view products button
      const SliverToBoxAdapter(child: SizedBox(height: 12)),
      SliverToBoxAdapter(
        child: Center(
          child: ClElevatedButton(
            onPressed: () {
              if (!enableButton) return;
            },
            child: const Text("Voir tous les produits"),
          ),
        ),
      )
    ],
  );
  }
}