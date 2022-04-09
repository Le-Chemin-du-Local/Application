import 'package:chemin_du_local/features/products/product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket_product.freezed.dart';
part 'basket_product.g.dart';

@immutable
@freezed
class BasketProduct with _$BasketProduct {
  const factory BasketProduct({
    required int quantity,
    required Product product,
  }) = _BasketProduct;

  factory BasketProduct.fromJson(Map<String, dynamic> json) => _$BasketProductFromJson(json);

}