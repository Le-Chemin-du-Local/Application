import 'package:chemin_du_local/features/basket/basket_commerce.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket.freezed.dart';

@freezed
@immutable
class Basket with _$Basket {
  const factory Basket({
    @Default(<BasketCommerce>[]) List<BasketCommerce> commerces,
  }) = _Basket;
}