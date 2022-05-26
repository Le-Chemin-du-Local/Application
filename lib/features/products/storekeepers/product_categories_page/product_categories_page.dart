import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_edit_page/product_edit_page.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_categories_page/widgets/product_categorie_card.dart';
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
          crossAxisSpacing: 23,
          mainAxisSpacing: 15
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
      floatingActionButton: !showAddButton ? null : FloatingActionButton(
        onPressed: () => _openProductCreationPage(context),
        child: const Icon(Icons.add),
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