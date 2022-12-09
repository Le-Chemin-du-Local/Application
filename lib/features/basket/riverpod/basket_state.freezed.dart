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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_BasketStateCopyWith<$Res>
    implements $BasketStateCopyWith<$Res> {
  factory _$$_BasketStateCopyWith(
          _$_BasketState value, $Res Function(_$_BasketState) then) =
      __$$_BasketStateCopyWithImpl<$Res>;
  @override
  $Res call({AsyncValue<Basket> basket});
}

/// @nodoc
class __$$_BasketStateCopyWithImpl<$Res> extends _$BasketStateCopyWithImpl<$Res>
    implements _$$_BasketStateCopyWith<$Res> {
  __$$_BasketStateCopyWithImpl(
      _$_BasketState _value, $Res Function(_$_BasketState) _then)
      : super(_value, (v) => _then(v as _$_BasketState));

  @override
  _$_BasketState get _value => super._value as _$_BasketState;

  @override
  $Res call({
    Object? basket = freezed,
  }) {
    return _then(_$_BasketState(
      basket: basket == freezed
          ? _value.basket
          : basket // ignore: cast_nullable_to_non_nullable
              as AsyncValue<Basket>,
    ));
  }
}

/// @nodoc

class _$_BasketState implements _BasketState {
  const _$_BasketState({required this.basket});

  @override
  final AsyncValue<Basket> basket;

  @override
  String toString() {
    return 'BasketState(basket: $basket)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BasketState &&
            const DeepCollectionEquality().equals(other.basket, basket));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(basket));

  @JsonKey(ignore: true)
  @override
  _$$_BasketStateCopyWith<_$_BasketState> get copyWith =>
      __$$_BasketStateCopyWithImpl<_$_BasketState>(this, _$identity);
}

abstract class _BasketState implements BasketState {
  const factory _BasketState({required final AsyncValue<Basket> basket}) =
      _$_BasketState;

  @override
  AsyncValue<Basket> get basket;
  @override
  @JsonKey(ignore: true)
  _$$_BasketStateCopyWith<_$_BasketState> get copyWith =>
      throw _privateConstructorUsedError;
}
