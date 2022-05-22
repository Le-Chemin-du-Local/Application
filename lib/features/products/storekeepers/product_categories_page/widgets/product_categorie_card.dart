import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class ProductCategoryCard extends StatelessWidget {
  const ProductCategoryCard({
    Key? key,
    required this.onClick,
    required this.categoryName
  }) : super(key: key);

  final Function() onClick;

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: ClCard(
        backgroundGradient: Palette.gradientPrimary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Icon(
                kCategorieLogo[categoryName] ?? Icons.error,
                size: 54,
                color: Palette.colorWhite,
              ),
            ),
            const SizedBox(height: 32,),
            Flexible(
              child: Text(
                categoryName, 
                textAlign: TextAlign.center,
                style: const TextStyle(color: Palette.colorWhite)
              ),
            )
          ],
        ),
      ),
    );
  }
}