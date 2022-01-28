import 'package:chemin_du_local/features/products/product_page.dart';
import 'package:chemin_du_local/features/products/products_controller.dart';
import 'package:chemin_du_local/features/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({
    Key? key,
    required this.category,
    this.showAppBar = true,
  }) : super(key: key);

  final String category;

  final bool showAppBar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: showAppBar ? AppBar() : null,
      body: ref.watch(productsControllerProvider).productsByCategory(category).when(
        data: (products) => GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 270,
            mainAxisExtent: 273,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16
          ),
          padding: const EdgeInsets.all(18),
          children: [
            for (final product in products) 
              InkWell(
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductPage(product: product,)
                    )
                  );
                },
                child: ProductCard(product: product)
              )
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator(),),
        error: (error, stackTrace) => Center(child: Text("Une erreur s'est produite : $error"),)

      ),
    );
  }
}