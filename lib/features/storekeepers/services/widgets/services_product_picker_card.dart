import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ServicesProductCard extends StatelessWidget {
  const ServicesProductCard({
    Key? key,
    required this.product,
    required this.isSelected,
    this.quantity,
    this.onQuantityChanged,
  }) : super(key: key);

  final Product product;
  final bool isSelected;

  final int? quantity;
  final Function(Product,int)? onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? 1.0 : 0.5,
      child: ProductCard(
        borderColor: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
        product: product,
        quantity: quantity ?? 0,
        showQuantityPicker: onQuantityChanged != null,
        onQuantityUpdated: (value) {
          if (onQuantityChanged != null) {
            onQuantityChanged!(product, value);
          }
        },
      ),
    );
  }
}