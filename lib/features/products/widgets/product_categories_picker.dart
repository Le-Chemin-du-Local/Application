import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/widgets/picker_category_button.dart';
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
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final category in categoryIcon.keys)
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