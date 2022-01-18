import 'package:chemin_du_local/features/products/products_controller.dart';
import 'package:chemin_du_local/features/products/widgets/product_category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCategoriesPage extends ConsumerWidget {
  const ProductCategoriesPage({
    Key? key,
    required this.onCategorySelected,
    required this.currentCategory
  }) : super(key: key);

  final String currentCategory;

  final Function(String) onCategorySelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(productsControllerProvider).categories.when(
      data: (categories) => GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 148,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        padding: const EdgeInsets.all(18.0),
        children: [
          for (final category in categories) 
            ProductCategoryCard(
              onClick: () => onCategorySelected(category),
              categoryName: category,
            )
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator(),),
      error: (error, stackTrace) => Text(error.toString())
    );
  }
}