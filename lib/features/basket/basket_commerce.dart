import 'package:chemin_du_local/features/basket/basket_product.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket_commerce.freezed.dart';
part 'basket_commerce.g.dart';

@freezed
@immutable
class BasketCommerce with _$BasketCommerce {
  const factory BasketCommerce({
    required Commerce commerce,
    @Default(<BasketProduct>[]) List<BasketProduct> products,
  }) = _BasketCommerce;

  factory BasketCommerce.fromJson(Map<String, dynamic> json) => _$BasketCommerceFromJson(json);
}