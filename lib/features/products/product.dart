import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

const Map<String, IconData> kCategorieLogo = {
  "Bières & cidres": CLIcons.bierescidres,
  "Spécialitées sucrées": CLIcons.specialitessucrees,
  "Spécialitées salées": CLIcons.specialitessalees,
};

@freezed
@immutable
class Product with _$Product {
  const factory Product(String? id, {
    required String name,
    @Default(<String>[]) List<String> categories,
    @Default(<String>[]) List<String> tags,
    String? description,
    double? price,
    String? unit,
    double? tva,
    bool? isBreton,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}