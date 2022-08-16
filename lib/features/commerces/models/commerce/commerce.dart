import 'package:chemin_du_local/features/commerces/models/business_hours/business_hours.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/user/models/cl_payment_method/cl_payment_method.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:chemin_du_local/features/place/models/address/address.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'commerce.freezed.dart';
part 'commerce.g.dart';

@freezed
@immutable
class Commerce with _$Commerce {
  const factory Commerce(String? id, {
    required String name,
    User? storekeeper,
    @Default(<String>[]) List<String> categories,
    @Default(<String>[]) List<String> services,
    @Default(<Product>[]) List<Product> productsAvailableForClickAndCollect,
    String? storekeeperWord,
    String? description,
    Address? address,
    String? phone,
    String? email,
    String? facebook,
    String? twitter,
    String? instagram,
    BusinessHours? businessHours,
    BusinessHours? clickAndCollectHours,
    double? latitude,
    double? longitude,
    ClPaymentMethod? defaultPaymentMethod,
    double? dueBalance,
    DateTime? lastBilledDate,
  }) = _Commerce;

  factory Commerce.fromJson(Map<String, dynamic> json) => _$CommerceFromJson(json);
}