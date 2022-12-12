import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket.freezed.dart';
part 'basket.g.dart';

@freezed
@immutable
class Basket with _$Basket {
  const Basket._();

  const factory Basket({
    @Default(<BasketCommerce>[]) List<BasketCommerce> commerces,
  }) = _Basket;

  factory Basket.fromJson(Map<String, dynamic> json) => _$BasketFromJson(json);

  int get count {
    int result = 0;
    for (final commerce in commerces) {
      for (final product in commerce.products) {
        result += product.quantity;
      }

      result += commerce.paniers.length;
    }

    return result;
  }
}