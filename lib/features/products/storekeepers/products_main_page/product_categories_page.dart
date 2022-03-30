import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/product_edit_page.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/product_categorie_card.dart';
import 'package:flutter/material.dart';

class ProductCategoriesPage extends StatelessWidget {
  const ProductCategoriesPage({
    Key? key,
    required this.onCategorySelected,
    required this.onProductUpdated,
    required this.currentCategory,
    required this.commerce,
    this.showAddButton = false,
  }) : super(key: key);

  final String currentCategory;
  final Commerce commerce;

  final bool showAddButton;

  final Function(String) onCategorySelected;
  final Function() onProductUpdated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 148,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        padding: const EdgeInsets.all(18.0),
        children: [
          for (final category in commerce.categories) 
            ProductCategoryCard(
              onClick: () => onCategorySelected(category),
              categoryName: category,
            )
        ],
      ),
      floatingActionButton: !showAddButton ? null : ClFloatingButton(
        onPressed: () => _openProductCreationPage(context),
        icon: Icons.add,
      ),
    );
  }

  Future _openProductCreationPage(BuildContext context) async {
    bool hasProductUpdate = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => const ProductPage(
          productID: null,
        )
      )
    ) ?? false;

    if (hasProductUpdate) onProductUpdated();
  }
}