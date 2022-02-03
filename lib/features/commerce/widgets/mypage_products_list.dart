import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/products/products_controller.dart';
import 'package:chemin_du_local/features/products/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MyPageProductsList extends ConsumerWidget {
  const MyPageProductsList({
    Key? key,
    required this.useBigLayout,
    required this.enableButton
  }) : super(key: key);

  final bool useBigLayout;
  final bool enableButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(productsControllerProvider).products.when(
      data: (products) {
        final List<Widget> content = [
          for (final product in products) 
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300, maxWidth: 200),
              child: ProductCard(product: product)
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
      },
      loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(),)),
      error: (error, stackTrace) => const SliverToBoxAdapter(child: Text("Erreur de chargement des produits")),
    );
  }
}