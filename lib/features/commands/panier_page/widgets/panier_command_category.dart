import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/product_categorie_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_product.dart';
import 'package:flutter/material.dart';

class PanierCommandCategory extends StatelessWidget {
  const PanierCommandCategory({
    Key? key,
    required this.category,
    required this.products
  }) : super(key: key);

  final String category;
  final List<PanierProduct> products;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > ScreenHelper.breakpointTablet) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // The category logo
              Flexible(
                flex: 2,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 120, maxHeight: 120),
                  child: ProductCategoryCard(
                    categoryName: category,
                    onClick: () {},
                  ),
                ),
              ),
              const SizedBox(width: 8,),

              // The products
              Expanded(
                flex: 8,
                child: _buildProductRows(),
              )
            ],
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The categoty icon
            SizedBox(
              width: 92,
              height: 110,
              child: ProductCategoryCard(
                categoryName: category,
                onClick: () {},
              ),
            ),
            const SizedBox(height: 12,),

            // The content
            Flexible(
              child: _buildProductRows(),
            )
          ],
        );
      }
    );
  }

  Widget _buildProductRows() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 12,),

        // The product details
        for (final product in products)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // The product name
                    Flexible(child: Text(product.product.name)),
              
                    // The product quantity
                    Flexible(child: Text("x${product.quantity}")),
                  ],
                ),
              ),


              // The product price
              Flexible(child: Text("${product.product.price}€")),
            ],
          )
      ],
    );
  }
}