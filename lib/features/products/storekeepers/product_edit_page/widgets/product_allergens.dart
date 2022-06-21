import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:flutter/material.dart';

class ProductAllergensPicker extends StatelessWidget {
  const ProductAllergensPicker({
    Key? key,
    required this.allergens,
    required this.onAllergenAdded,
    required this.onAllergenRemoved
  }) : super(key: key);

  final List<String> allergens;

  final Function(String) onAllergenAdded;
  final Function(String) onAllergenRemoved;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Allergènes", 
          style: ScreenHelper.instance.isMobile 
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.headlineSmall
        ),
        const SizedBox(height: 8),

        Wrap(
          spacing: 4, runSpacing: 4,
          children: [
            for (final allergen in kAllergensList) 
              SizedBox(
                width: 200,
                child: ClCheckBox(
                  value: allergens.contains(allergen),
                  text: allergen,
                  onChanged: (value) {
                    if (value ?? false) {
                      onAllergenAdded(allergen);
                    }
                    else {
                      onAllergenRemoved(allergen);
                    }
                  },
                ),
              )
          ],
        )
      ],
    );
  }
}