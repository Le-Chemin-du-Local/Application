import 'package:chemin_du_local/features/basket/basket_product.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket.freezed.dart';

@freezed
@immutable
class Basket with _$Basket {
  const factory Basket({
    required Map<String, List<BasketProduct>> products,
    required List<Commerce> commerces,
  }) = _Basket;
}