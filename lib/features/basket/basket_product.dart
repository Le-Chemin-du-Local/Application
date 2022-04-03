import 'package:chemin_du_local/features/products/product.dart';

class BasketProduct {
  final Product product;
  final int quantity;

  const BasketProduct(this.product, this.quantity);
}