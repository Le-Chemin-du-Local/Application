import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
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
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // L'icone de la catégorie
            Flexible(
              // height: 120,
              flex: 66,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)
                  )
                ),
                child: Center(
                  child: Icon(
                    kCategorieLogo[categoryName] ?? Icons.error,
                    size: 90,
                    color: Theme.of(context).colorScheme.secondary
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8,),

            Flexible(
              flex: 33,
              child: Text(
                categoryName, 
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}