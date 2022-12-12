import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

const List<String> kCategories = [
  "Bio",
  "Bières & cidres",
  "Boissons sans alcool",
  "Vins & spiritueux",
  "Pains & boulangerie",
  "Produits laitiers",
  "Epicerie",
  "Fruits",
  "Légumes",
  "Horticulture",
  "Produits de la mer",
  "Viandes",
  "Spécialitées salées",
  "Spécialitées sucrées",
];

const Map<String, IconData> kCategorieLogo = {
  "Bio": CLIcons.bio,
  "Bières & cidres": CLIcons.bieresCidres,
  "Boissons sans alcool": CLIcons.boissonsSansAlcool,
  "Vins & spiritueux": CLIcons.vinsSpiritueux,
  "Pains & boulangerie": CLIcons.boulangeriePain,
  "Produits laitiers": CLIcons.produitsLaitiers,
  "Epicerie": CLIcons.epicerie,
  "Fruits": CLIcons.fruits,
  "Légumes": CLIcons.legumes,
  "Horticulture": CLIcons.horticulture,
  "Produits de la mer": CLIcons.produitsMer,
  "Viandes": CLIcons.viandes,
  "Spécialitées salées": CLIcons.specialitesSalees,
  "Spécialitées sucrées": CLIcons.specialitesSucrees,
};

// La liste des allèrgenes 
const kAllergensList = [
  "Crustacés", "Oeufs", "Poissons", "Volaille", "Arachides", "Moutarde", "Lupin",
  "Fruits à coques", "Soja", "Céleri", "Lait"
];

@Freezed(makeCollectionsUnmodifiable: false)
@immutable
class Product with _$Product {
  const factory Product(String? id, {
    required String name,
    @Default(<String>[]) List<String> categories,
    @Default(<String>[]) List<String> tags,
    @Default(<String>[]) List<String> allergens,
    String? description,
    double? price,
    String? unit,
    double? perUnitQuantity,
    String? perUnitQuantityUnit,
    double? tva,
    bool? isBreton,
    bool? hasGluten,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}