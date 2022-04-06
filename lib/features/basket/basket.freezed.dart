// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'basket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$BasketTearOff {
  const _$BasketTearOff();

  _Basket call({List<BasketCommerce> commerces = const <BasketCommerce>[]}) {
    return _Basket(
      commerces: commerces,
    );
  }
}

/// @nodoc
const $Basket = _$BasketTearOff();

/// @nodoc
mixin _$Basket {
  List<BasketCommerce> get commerces => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BasketCopyWith<Basket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasketCopyWith<$Res> {
  factory $BasketCopyWith(Basket value, $Res Function(Basket) then) =
      _$BasketCopyWithImpl<$Res>;
  $Res call({List<BasketCommerce> commerces});
}

/// @nodoc
class _$BasketCopyWithImpl<$Res> implements $BasketCopyWith<$Res> {
  _$BasketCopyWithImpl(this._value, this._then);

  final Basket _value;
  // ignore: unused_field
  final $Res Function(Basket) _then;

  @override
  $Res call({
    Object? commerces = freezed,
  }) {
    return _then(_value.copyWith(
      commerces: commerces == freezed
          ? _value.commerces
          : commerces // ignore: cast_nullable_to_non_nullable
              as List<BasketCommerce>,
    ));
  }
}

/// @nodoc
abstract class _$BasketCopyWith<$Res> implements $BasketCopyWith<$Res> {
  factory _$BasketCopyWith(_Basket value, $Res Function(_Basket) then) =
      __$BasketCopyWithImpl<$Res>;
  @override
  $Res call({List<BasketCommerce> commerces});
}

/// @nodoc
class __$BasketCopyWithImpl<$Res> extends _$BasketCopyWithImpl<$Res>
    implements _$BasketCopyWith<$Res> {
  __$BasketCopyWithImpl(_Basket _value, $Res Function(_Basket) _then)
      : super(_value, (v) => _then(v as _Basket));

  @override
  _Basket get _value => super._value as _Basket;

  @override
  $Res call({
    Object? commerces = freezed,
  }) {
    return _then(_Basket(
      commerces: commerces == freezed
          ? _value.commerces
          : commerces // ignore: cast_nullable_to_non_nullable
              as List<BasketCommerce>,
    ));
  }
}

/// @nodoc

class _$_Basket with DiagnosticableTreeMixin implements _Basket {
  const _$_Basket({this.commerces = const <BasketCommerce>[]});

  @JsonKey()
  @override
  final List<BasketCommerce> commerces;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Basket(commerces: $commerces)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Basket'))
      ..add(DiagnosticsProperty('commerces', commerces));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Basket &&
            const DeepCollectionEquality().equals(other.commerces, commerces));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(commerces));

  @JsonKey(ignore: true)
  @override
  _$BasketCopyWith<_Basket> get copyWith =>
      __$BasketCopyWithImpl<_Basket>(this, _$identity);
}

abstract class _Basket implements Basket {
  const factory _Basket({List<BasketCommerce> commerces}) = _$_Basket;

  @override
  List<BasketCommerce> get commerces;
  @override
  @JsonKey(ignore: true)
  _$BasketCopyWith<_Basket> get copyWith => throw _privateConstructorUsedError;
}
