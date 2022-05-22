import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'basket_state.freezed.dart';

@freezed
@immutable
class BasketState with _$BasketState {
  const factory BasketState({
    required AsyncValue<Basket> basket,
  }) = _BasketState;
}