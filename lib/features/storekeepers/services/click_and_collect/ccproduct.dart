import 'package:chemin_du_local/features/products/product.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ccproduct.freezed.dart';
part 'ccproduct.g.dart';

@freezed
@immutable
class CCProduct with _$CCProduct {
  const factory CCProduct({
    required int quantity,
    required Product product
  }) = _CCProduct;

  factory CCProduct.fromJson(Map<String, dynamic> json) => _$CCProductFromJson(json);
}