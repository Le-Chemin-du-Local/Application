import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/foundation.dart';
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
  "Bières & cidres": CLIcons.bierescidres,
  "Boissons sans alcool": CLIcons.boissonssansalcool,
  "Vins & spiritueux": CLIcons.vinsspiritueux,
  "Pains & boulangerie": CLIcons.boulangeriepain,
  "Produits laitiers": CLIcons.produitslaitiers,
  "Epicerie": CLIcons.epicescondiments,
  "Fruits": CLIcons.fruits,
  "Légumes": CLIcons.legumes,
  "Horticulture": CLIcons.horticulture,
  "Produits de la mer": CLIcons.produitsmer,
  "Viandes": CLIcons.viandes,
  "Spécialitées salées": CLIcons.specialitessalees,
  "Spécialitées sucrées": CLIcons.specialitessucrees,
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
    double? tva,
    bool? isBreton,
    bool? hasGluten,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}