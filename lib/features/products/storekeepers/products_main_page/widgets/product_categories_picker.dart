import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/picker_category_button.dart';
import 'package:flutter/material.dart';

class ProductCategoriesPicker extends StatelessWidget {
  const ProductCategoriesPicker({
    Key? key,
    required this.onRemoveCategory,
    required this.onAddCategory,
    required this.initialCategories
  }) : super(key: key);

  final Function(String) onRemoveCategory;
  final Function(String) onAddCategory;

  final List<String> initialCategories;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Catégories", style: TextStyle(fontSize: 14)),  
        const SizedBox(height: 12,),
        Flexible(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 178,
              mainAxisExtent: 220,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16
            ),
            shrinkWrap: true,
            primary: false,
            children: [
              for (final category in kCategorieLogo.keys)
                PickerCategoryButton(
                  name: category, 
                  isSelected: initialCategories.contains(category),
                  onTap: (isSelected) => isSelected ? onAddCategory(category) : onRemoveCategory(category) 
                )
            ],
          ),
        )
      ],
    );
  }
}