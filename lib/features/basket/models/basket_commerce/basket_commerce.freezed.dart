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
  String get commerceID => throw _privateConstructorUsedError;
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
      {String commerceID,
      List<BasketProduct> products,
      List<Panier> paniers,
      DateTime? pickupDate});
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
    Object? commerceID = freezed,
    Object? products = freezed,
    Object? paniers = freezed,
    Object? pickupDate = freezed,
  }) {
    return _then(_value.copyWith(
      commerceID: commerceID == freezed
          ? _value.commerceID
          : commerceID // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$$_BasketCommerceCopyWith<$Res>
    implements $BasketCommerceCopyWith<$Res> {
  factory _$$_BasketCommerceCopyWith(
          _$_BasketCommerce value, $Res Function(_$_BasketCommerce) then) =
      __$$_BasketCommerceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String commerceID,
      List<BasketProduct> products,
      List<Panier> paniers,
      DateTime? pickupDate});
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
    Object? commerceID = freezed,
    Object? products = freezed,
    Object? paniers = freezed,
    Object? pickupDate = freezed,
  }) {
    return _then(_$_BasketCommerce(
      commerceID: commerceID == freezed
          ? _value.commerceID
          : commerceID // ignore: cast_nullable_to_non_nullable
              as String,
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
class _$_BasketCommerce implements _BasketCommerce {
  const _$_BasketCommerce(
      {required this.commerceID,
      final List<BasketProduct> products = const <BasketProduct>[],
      final List<Panier> paniers = const <Panier>[],
      this.pickupDate})
      : _products = products,
        _paniers = paniers;

  factory _$_BasketCommerce.fromJson(Map<String, dynamic> json) =>
      _$$_BasketCommerceFromJson(json);

  @override
  final String commerceID;
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
  String toString() {
    return 'BasketCommerce(commerceID: $commerceID, products: $products, paniers: $paniers, pickupDate: $pickupDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BasketCommerce &&
            const DeepCollectionEquality()
                .equals(other.commerceID, commerceID) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality().equals(other._paniers, _paniers) &&
            const DeepCollectionEquality()
                .equals(other.pickupDate, pickupDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(commerceID),
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_paniers),
      const DeepCollectionEquality().hash(pickupDate));

  @JsonKey(ignore: true)
  @override
  _$$_BasketCommerceCopyWith<_$_BasketCommerce> get copyWith =>
      __$$_BasketCommerceCopyWithImpl<_$_BasketCommerce>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BasketCommerceToJson(
      this,
    );
  }
}

abstract class _BasketCommerce implements BasketCommerce {
  const factory _BasketCommerce(
      {required final String commerceID,
      final List<BasketProduct> products,
      final List<Panier> paniers,
      final DateTime? pickupDate}) = _$_BasketCommerce;

  factory _BasketCommerce.fromJson(Map<String, dynamic> json) =
      _$_BasketCommerce.fromJson;

  @override
  String get commerceID;
  @override
  List<BasketProduct> get products;
  @override
  List<Panier> get paniers;
  @override
  DateTime? get pickupDate;
  @override
  @JsonKey(ignore: true)
  _$$_BasketCommerceCopyWith<_$_BasketCommerce> get copyWith =>
      throw _privateConstructorUsedError;
}
