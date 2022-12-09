// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'panier_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PanierProduct _$PanierProductFromJson(Map<String, dynamic> json) {
  return _PanierProduct.fromJson(json);
}

/// @nodoc
mixin _$PanierProduct {
  int get quantity => throw _privateConstructorUsedError;
  Product get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PanierProductCopyWith<PanierProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanierProductCopyWith<$Res> {
  factory $PanierProductCopyWith(
          PanierProduct value, $Res Function(PanierProduct) then) =
      _$PanierProductCopyWithImpl<$Res>;
  $Res call({int quantity, Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$PanierProductCopyWithImpl<$Res>
    implements $PanierProductCopyWith<$Res> {
  _$PanierProductCopyWithImpl(this._value, this._then);

  final PanierProduct _value;
  // ignore: unused_field
  final $Res Function(PanierProduct) _then;

  @override
  $Res call({
    Object? quantity = freezed,
    Object? product = freezed,
  }) {
    return _then(_value.copyWith(
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }

  @override
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value));
    });
  }
}

/// @nodoc
abstract class _$$_PanierProductCopyWith<$Res>
    implements $PanierProductCopyWith<$Res> {
  factory _$$_PanierProductCopyWith(
          _$_PanierProduct value, $Res Function(_$_PanierProduct) then) =
      __$$_PanierProductCopyWithImpl<$Res>;
  @override
  $Res call({int quantity, Product product});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$_PanierProductCopyWithImpl<$Res>
    extends _$PanierProductCopyWithImpl<$Res>
    implements _$$_PanierProductCopyWith<$Res> {
  __$$_PanierProductCopyWithImpl(
      _$_PanierProduct _value, $Res Function(_$_PanierProduct) _then)
      : super(_value, (v) => _then(v as _$_PanierProduct));

  @override
  _$_PanierProduct get _value => super._value as _$_PanierProduct;

  @override
  $Res call({
    Object? quantity = freezed,
    Object? product = freezed,
  }) {
    return _then(_$_PanierProduct(
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      product: product == freezed
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PanierProduct implements _PanierProduct {
  const _$_PanierProduct({required this.quantity, required this.product});

  factory _$_PanierProduct.fromJson(Map<String, dynamic> json) =>
      _$$_PanierProductFromJson(json);

  @override
  final int quantity;
  @override
  final Product product;

  @override
  String toString() {
    return 'PanierProduct(quantity: $quantity, product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PanierProduct &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.product, product));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(product));

  @JsonKey(ignore: true)
  @override
  _$$_PanierProductCopyWith<_$_PanierProduct> get copyWith =>
      __$$_PanierProductCopyWithImpl<_$_PanierProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PanierProductToJson(
      this,
    );
  }
}

abstract class _PanierProduct implements PanierProduct {
  const factory _PanierProduct(
      {required final int quantity,
      required final Product product}) = _$_PanierProduct;

  factory _PanierProduct.fromJson(Map<String, dynamic> json) =
      _$_PanierProduct.fromJson;

  @override
  int get quantity;
  @override
  Product get product;
  @override
  @JsonKey(ignore: true)
  _$$_PanierProductCopyWith<_$_PanierProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
