import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user_state.freezed.dart';

@freezed
@immutable
class AppUserState with _$AppUserState {
  const factory AppUserState({
    String? token,
    @Default(false) bool goBackToBasketPayment,
  }) = _AppUserState;
}