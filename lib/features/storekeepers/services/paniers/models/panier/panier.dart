import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier_product/panier_product.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'panier.freezed.dart';
part 'panier.g.dart';

mixin PanierType {
  static const String permanent = "PERMANENT";
  static const String temporary = "TEMPORARY";

  static const Map<String, String> detailled = {
    permanent: "Permanent",
    temporary: "Temporaire"
  };
}

@freezed
@immutable
class Panier with _$Panier {
  const factory Panier(String? id, {
    required String name,
    required String type,
    @Default("Autre") String category,
    @Default("") String description,
    @Default(0) int quantity,
    @Default(0) double price,
    @Default(0) double reduction,
    @Default(<PanierProduct>[]) List<PanierProduct> products,
    DateTime? endingDate,
  }) = _PanierProduct;

  factory Panier.fromJson(Map<String, dynamic> json) => _$PanierFromJson(json);
}