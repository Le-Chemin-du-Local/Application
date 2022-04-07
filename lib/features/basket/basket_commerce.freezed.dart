// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'basket_commerce.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BasketCommerce _$BasketCommerceFromJson(Map<String, dynamic> json) {
  return _BasketCommerce.fromJson(json);
}

/// @nodoc
class _$BasketCommerceTearOff {
  const _$BasketCommerceTearOff();

  _BasketCommerce call(
      {required Commerce commerce,
      List<BasketProduct> products = const <BasketProduct>[],
      List<Panier> paniers = const <Panier>[],
      DateTime? pickupDate}) {
    return _BasketCommerce(
      commerce: commerce,
      products: products,
      paniers: paniers,
      pickupDate: pickupDate,
    );
  }

  BasketCommerce fromJson(Map<String, Object?> json) {
    return BasketCommerce.fromJson(json);
  }
}

/// @nodoc
const $BasketCommerce = _$BasketCommerceTearOff();

/// @nodoc
mixin _$BasketCommerce {
  Commerce get commerce => throw _privateConstructorUsedError;
  List<BasketProduct> get products => throw _privateConstructorUsedError;
  List<Panier> get paniers => throw _privateConstructorUsedError;
  DateTime? get pickupDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BasketCommerceCopyWith<BasketCommerce> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasketCommerceCopyWith<$Res> {
  factory $BasketCommerceCopyWith(
          BasketCommerce value, $Res Function(BasketCommerce) then) =
      _$BasketCommerceCopyWithImpl<$Res>;
  $Res call(
      {Commerce commerce,
      List<BasketProduct> products,
      List<Panier> paniers,
      DateTime? pickupDate});

  $CommerceCopyWith<$Res> get commerce;
}

/// @nodoc
class _$BasketCommerceCopyWithImpl<$Res>
    implements $BasketCommerceCopyWith<$Res> {
  _$BasketCommerceCopyWithImpl(this._value, this._then);

  final BasketCommerce _value;
  // ignore: unused_field
  final $Res Function(BasketCommerce) _then;

  @override
  $Res call({
    Object? commerce = freezed,
    Object? products = freezed,
    Object? paniers = freezed,
    Object? pickupDate = freezed,
  }) {
    return _then(_value.copyWith(
      commerce: commerce == freezed
          ? _value.commerce
          : commerce // ignore: cast_nullable_to_non_nullable
              as Commerce,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<BasketProduct>,
      paniers: paniers == freezed
          ? _value.paniers
          : paniers // ignore: cast_nullable_to_non_nullable
              as List<Panier>,
      pickupDate: pickupDate == freezed
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $CommerceCopyWith<$Res> get commerce {
    return $CommerceCopyWith<$Res>(_value.commerce, (value) {
      return _then(_value.copyWith(commerce: value));
    });
  }
}

/// @nodoc
abstract class _$BasketCommerceCopyWith<$Res>
    implements $BasketCommerceCopyWith<$Res> {
  factory _$BasketCommerceCopyWith(
          _BasketCommerce value, $Res Function(_BasketCommerce) then) =
      __$BasketCommerceCopyWithImpl<$Res>;
  @override
  $Res call(
      {Commerce commerce,
      List<BasketProduct> products,
      List<Panier> paniers,
      DateTime? pickupDate});

  @override
  $CommerceCopyWith<$Res> get commerce;
}

/// @nodoc
class __$BasketCommerceCopyWithImpl<$Res>
    extends _$BasketCommerceCopyWithImpl<$Res>
    implements _$BasketCommerceCopyWith<$Res> {
  __$BasketCommerceCopyWithImpl(
      _BasketCommerce _value, $Res Function(_BasketCommerce) _then)
      : super(_value, (v) => _then(v as _BasketCommerce));

  @override
  _BasketCommerce get _value => super._value as _BasketCommerce;

  @override
  $Res call({
    Object? commerce = freezed,
    Object? products = freezed,
    Object? paniers = freezed,
    Object? pickupDate = freezed,
  }) {
    return _then(_BasketCommerce(
      commerce: commerce == freezed
          ? _value.commerce
          : commerce // ignore: cast_nullable_to_non_nullable
              as Commerce,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<BasketProduct>,
      paniers: paniers == freezed
          ? _value.paniers
          : paniers // ignore: cast_nullable_to_non_nullable
              as List<Panier>,
      pickupDate: pickupDate == freezed
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BasketCommerce
    with DiagnosticableTreeMixin
    implements _BasketCommerce {
  const _$_BasketCommerce(
      {required this.commerce,
      this.products = const <BasketProduct>[],
      this.paniers = const <Panier>[],
      this.pickupDate});

  factory _$_BasketCommerce.fromJson(Map<String, dynamic> json) =>
      _$$_BasketCommerceFromJson(json);

  @override
  final Commerce commerce;
  @JsonKey()
  @override
  final List<BasketProduct> products;
  @JsonKey()
  @override
  final List<Panier> paniers;
  @override
  final DateTime? pickupDate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BasketCommerce(commerce: $commerce, products: $products, paniers: $paniers, pickupDate: $pickupDate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BasketCommerce'))
      ..add(DiagnosticsProperty('commerce', commerce))
      ..add(DiagnosticsProperty('products', products))
      ..add(DiagnosticsProperty('paniers', paniers))
      ..add(DiagnosticsProperty('pickupDate', pickupDate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BasketCommerce &&
            const DeepCollectionEquality().equals(other.commerce, commerce) &&
            const DeepCollectionEquality().equals(other.products, products) &&
            const DeepCollectionEquality().equals(other.paniers, paniers) &&
            const DeepCollectionEquality()
                .equals(other.pickupDate, pickupDate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(commerce),
      const DeepCollectionEquality().hash(products),
      const DeepCollectionEquality().hash(paniers),
      const DeepCollectionEquality().hash(pickupDate));

  @JsonKey(ignore: true)
  @override
  _$BasketCommerceCopyWith<_BasketCommerce> get copyWith =>
      __$BasketCommerceCopyWithImpl<_BasketCommerce>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BasketCommerceToJson(this);
  }
}

abstract class _BasketCommerce implements BasketCommerce {
  const factory _BasketCommerce(
      {required Commerce commerce,
      List<BasketProduct> products,
      List<Panier> paniers,
      DateTime? pickupDate}) = _$_BasketCommerce;

  factory _BasketCommerce.fromJson(Map<String, dynamic> json) =
      _$_BasketCommerce.fromJson;

  @override
  Commerce get commerce;
  @override
  List<BasketProduct> get products;
  @override
  List<Panier> get paniers;
  @override
  DateTime? get pickupDate;
  @override
  @JsonKey(ignore: true)
  _$BasketCommerceCopyWith<_BasketCommerce> get copyWith =>
      throw _privateConstructorUsedError;
}
