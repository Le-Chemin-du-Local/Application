// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_user_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppUserState {
  String? get token => throw _privateConstructorUsedError;
  bool get goBackToBasketPayment => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppUserStateCopyWith<AppUserState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserStateCopyWith<$Res> {
  factory $AppUserStateCopyWith(
          AppUserState value, $Res Function(AppUserState) then) =
      _$AppUserStateCopyWithImpl<$Res>;
  $Res call({String? token, bool goBackToBasketPayment});
}

/// @nodoc
class _$AppUserStateCopyWithImpl<$Res> implements $AppUserStateCopyWith<$Res> {
  _$AppUserStateCopyWithImpl(this._value, this._then);

  final AppUserState _value;
  // ignore: unused_field
  final $Res Function(AppUserState) _then;

  @override
  $Res call({
    Object? token = freezed,
    Object? goBackToBasketPayment = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      goBackToBasketPayment: goBackToBasketPayment == freezed
          ? _value.goBackToBasketPayment
          : goBackToBasketPayment // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_AppUserStateCopyWith<$Res>
    implements $AppUserStateCopyWith<$Res> {
  factory _$$_AppUserStateCopyWith(
          _$_AppUserState value, $Res Function(_$_AppUserState) then) =
      __$$_AppUserStateCopyWithImpl<$Res>;
  @override
  $Res call({String? token, bool goBackToBasketPayment});
}

/// @nodoc
class __$$_AppUserStateCopyWithImpl<$Res>
    extends _$AppUserStateCopyWithImpl<$Res>
    implements _$$_AppUserStateCopyWith<$Res> {
  __$$_AppUserStateCopyWithImpl(
      _$_AppUserState _value, $Res Function(_$_AppUserState) _then)
      : super(_value, (v) => _then(v as _$_AppUserState));

  @override
  _$_AppUserState get _value => super._value as _$_AppUserState;

  @override
  $Res call({
    Object? token = freezed,
    Object? goBackToBasketPayment = freezed,
  }) {
    return _then(_$_AppUserState(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      goBackToBasketPayment: goBackToBasketPayment == freezed
          ? _value.goBackToBasketPayment
          : goBackToBasketPayment // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AppUserState implements _AppUserState {
  const _$_AppUserState({this.token, this.goBackToBasketPayment = false});

  @override
  final String? token;
  @override
  @JsonKey()
  final bool goBackToBasketPayment;

  @override
  String toString() {
    return 'AppUserState(token: $token, goBackToBasketPayment: $goBackToBasketPayment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUserState &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality()
                .equals(other.goBackToBasketPayment, goBackToBasketPayment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(goBackToBasketPayment));

  @JsonKey(ignore: true)
  @override
  _$$_AppUserStateCopyWith<_$_AppUserState> get copyWith =>
      __$$_AppUserStateCopyWithImpl<_$_AppUserState>(this, _$identity);
}

abstract class _AppUserState implements AppUserState {
  const factory _AppUserState(
      {final String? token,
      final bool goBackToBasketPayment}) = _$_AppUserState;

  @override
  String? get token;
  @override
  bool get goBackToBasketPayment;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserStateCopyWith<_$_AppUserState> get copyWith =>
      throw _privateConstructorUsedError;
}
