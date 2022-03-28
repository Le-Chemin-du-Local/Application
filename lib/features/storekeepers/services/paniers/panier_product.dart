import 'package:chemin_du_local/features/products/product.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'panier_product.freezed.dart';
part 'panier_product.g.dart';

@freezed
@immutable
class PanierProduct with _$PanierProduct {
  const factory PanierProduct({
    required int quantity,
    required Product product
  }) = _PanierProduct;

  factory PanierProduct.fromJson(Map<String, dynamic> json) => _$PanierProductFromJson(json);
}