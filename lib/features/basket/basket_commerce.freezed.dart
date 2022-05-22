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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BasketCommerce _$BasketCommerceFromJson(Map<String, dynamic> json) {
  return _BasketCommerce.fromJson(json);
}

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
abstract class _$$_BasketCommerceCopyWith<$Res>
    implements $BasketCommerceCopyWith<$Res> {
  factory _$$_BasketCommerceCopyWith(
          _$_BasketCommerce value, $Res Function(_$_BasketCommerce) then) =
      __$$_BasketCommerceCopyWithImpl<$Res>;
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
class __$$_BasketCommerceCopyWithImpl<$Res>
    extends _$BasketCommerceCopyWithImpl<$Res>
    implements _$$_BasketCommerceCopyWith<$Res> {
  __$$_BasketCommerceCopyWithImpl(
      _$_BasketCommerce _value, $Res Function(_$_BasketCommerce) _then)
      : super(_value, (v) => _then(v as _$_BasketCommerce));

  @override
  _$_BasketCommerce get _value => super._value as _$_BasketCommerce;

  @override
  $Res call({
    Object? commerce = freezed,
    Object? products = freezed,
    Object? paniers = freezed,
    Object? pickupDate = freezed,
  }) {
    return _then(_$_BasketCommerce(
      commerce: commerce == freezed
          ? _value.commerce
          : commerce // ignore: cast_nullable_to_non_nullable
              as Commerce,
      products: products == freezed
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<BasketProduct>,
      paniers: paniers == freezed
          ? _value._paniers
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
      final List<BasketProduct> products = const <BasketProduct>[],
      final List<Panier> paniers = const <Panier>[],
      this.pickupDate})
      : _products = products,
        _paniers = paniers;

  factory _$_BasketCommerce.fromJson(Map<String, dynamic> json) =>
      _$$_BasketCommerceFromJson(json);

  @override
  final Commerce commerce;
  final List<BasketProduct> _products;
  @override
  @JsonKey()
  List<BasketProduct> get products {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  final List<Panier> _paniers;
  @override
  @JsonKey()
  List<Panier> get paniers {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_paniers);
  }

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
            other is _$_BasketCommerce &&
            const DeepCollectionEquality().equals(other.commerce, commerce) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._paniers, _paniers) &&
            const DeepCollectionEquality()
                .equals(other.pickupDate, pickupDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(commerce),
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_paniers),
      const DeepCollectionEquality().hash(pickupDate));

  @JsonKey(ignore: true)
  @override
  _$$_BasketCommerceCopyWith<_$_BasketCommerce> get copyWith =>
      __$$_BasketCommerceCopyWithImpl<_$_BasketCommerce>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BasketCommerceToJson(this);
  }
}

abstract class _BasketCommerce implements BasketCommerce {
  const factory _BasketCommerce(
      {required final Commerce commerce,
      final List<BasketProduct> products,
      final List<Panier> paniers,
      final DateTime? pickupDate}) = _$_BasketCommerce;

  factory _BasketCommerce.fromJson(Map<String, dynamic> json) =
      _$_BasketCommerce.fromJson;

  @override
  Commerce get commerce => throw _privateConstructorUsedError;
  @override
  List<BasketProduct> get products => throw _privateConstructorUsedError;
  @override
  List<Panier> get paniers => throw _privateConstructorUsedError;
  @override
  DateTime? get pickupDate => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_BasketCommerceCopyWith<_$_BasketCommerce> get copyWith =>
      throw _privateConstructorUsedError;
}
