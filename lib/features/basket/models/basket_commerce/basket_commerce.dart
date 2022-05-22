import 'package:chemin_du_local/features/basket/models/basket_product/basket_product.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier/panier.dart';
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
    @Default(<Panier>[]) List<Panier> paniers,
    DateTime? pickupDate,
  }) = _BasketCommerce;

  factory BasketCommerce.fromJson(Map<String, dynamic> json) => _$BasketCommerceFromJson(json);
}