import 'package:chemin_du_local/core/widgets/cl_card.dart';
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Icon(
                Icons.wine_bar,
                size: 54,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 32,),
            Flexible(
              child: Text(
                categoryName, 
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).primaryColor)
              ),
            )
          ],
        ),
      ),
    );
  }
}