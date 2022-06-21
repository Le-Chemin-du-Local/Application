import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/products/storekeepers/product_categories_page/widgets/picker_category_button.dart';
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
        Text(
          "Catégories", 
          style: ScreenHelper.instance.isMobile 
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.headlineMedium
        ),
        const SizedBox(height: 12,),
        Flexible(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 205,
              mainAxisExtent: 205,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14
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