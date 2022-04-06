// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'basket_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BasketStateTearOff {
  const _$BasketStateTearOff();

  _BasketState call({required AsyncValue<Basket> basket}) {
    return _BasketState(
      basket: basket,
    );
  }
}

/// @nodoc
const $BasketState = _$BasketStateTearOff();

/// @nodoc
mixin _$BasketState {
  AsyncValue<Basket> get basket => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BasketStateCopyWith<BasketState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasketStateCopyWith<$Res> {
  factory $BasketStateCopyWith(
          BasketState value, $Res Function(BasketState) then) =
      _$BasketStateCopyWithImpl<$Res>;
  $Res call({AsyncValue<Basket> basket});
}

/// @nodoc
class _$BasketStateCopyWithImpl<$Res> implements $BasketStateCopyWith<$Res> {
  _$BasketStateCopyWithImpl(this._value, this._then);

  final BasketState _value;
  // ignore: unused_field
  final $Res Function(BasketState) _then;

  @override
  $Res call({
    Object? basket = freezed,
  }) {
    return _then(_value.copyWith(
      basket: basket == freezed
          ? _value.basket
          : basket // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Basket>,
    ));
  }
}

/// @nodoc
abstract class _$BasketStateCopyWith<$Res>
    implements $BasketStateCopyWith<$Res> {
  factory _$BasketStateCopyWith(
          _BasketState value, $Res Function(_BasketState) then) =
      __$BasketStateCopyWithImpl<$Res>;
  @override
  $Res call({AsyncValue<Basket> basket});
}

/// @nodoc
class __$BasketStateCopyWithImpl<$Res> extends _$BasketStateCopyWithImpl<$Res>
    implements _$BasketStateCopyWith<$Res> {
  __$BasketStateCopyWithImpl(
      _BasketState _value, $Res Function(_BasketState) _then)
      : super(_value, (v) => _then(v as _BasketState));

  @override
  _BasketState get _value => super._value as _BasketState;

  @override
  $Res call({
    Object? basket = freezed,
  }) {
    return _then(_BasketState(
      basket: basket == freezed
          ? _value.basket
          : basket // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Basket>,
    ));
  }
}

/// @nodoc

class _$_BasketState with DiagnosticableTreeMixin implements _BasketState {
  const _$_BasketState({required this.basket});

  @override
  final AsyncValue<Basket> basket;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BasketState(basket: $basket)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BasketState'))
      ..add(DiagnosticsProperty('basket', basket));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BasketState &&
            const DeepCollectionEquality().equals(other.basket, basket));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(basket));

  @JsonKey(ignore: true)
  @override
  _$BasketStateCopyWith<_BasketState> get copyWith =>
      __$BasketStateCopyWithImpl<_BasketState>(this, _$identity);
}

abstract class _BasketState implements BasketState {
  const factory _BasketState({required AsyncValue<Basket> basket}) =
      _$_BasketState;

  @override
  AsyncValue<Basket> get basket;
  @override
  @JsonKey(ignore: true)
  _$BasketStateCopyWith<_BasketState> get copyWith =>
      throw _privateConstructorUsedError;
}
