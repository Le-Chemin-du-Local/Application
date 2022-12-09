// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'basket_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BasketProduct _$BasketProductFromJson(Map<String, dynamic> json) {
  return _BasketProduct.fromJson(json);
}

/// @nodoc
mixin _$BasketProduct {
  int get quantity => throw _privateConstructorUsedError;
  Product get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BasketProductCopyWith<BasketProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasketProductCopyWith<$Res> {
  factory $BasketProductCopyWith(
          BasketProduct value, $Res Function(BasketProduct) then) =
      _$BasketProductCopyWithImpl<$Res>;
  $Res call({int quantity, Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$BasketProductCopyWithImpl<$Res>
    implements $BasketProductCopyWith<$Res> {
  _$BasketProductCopyWithImpl(this._value, this._then);

  final BasketProduct _value;
  // ignore: unused_field
  final $Res Function(BasketProduct) _then;

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
abstract class _$$_BasketProductCopyWith<$Res>
    implements $BasketProductCopyWith<$Res> {
  factory _$$_BasketProductCopyWith(
          _$_BasketProduct value, $Res Function(_$_BasketProduct) then) =
      __$$_BasketProductCopyWithImpl<$Res>;
  @override
  $Res call({int quantity, Product product});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$_BasketProductCopyWithImpl<$Res>
    extends _$BasketProductCopyWithImpl<$Res>
    implements _$$_BasketProductCopyWith<$Res> {
  __$$_BasketProductCopyWithImpl(
      _$_BasketProduct _value, $Res Function(_$_BasketProduct) _then)
      : super(_value, (v) => _then(v as _$_BasketProduct));

  @override
  _$_BasketProduct get _value => super._value as _$_BasketProduct;

  @override
  $Res call({
    Object? quantity = freezed,
    Object? product = freezed,
  }) {
    return _then(_$_BasketProduct(
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
class _$_BasketProduct implements _BasketProduct {
  const _$_BasketProduct({required this.quantity, required this.product});

  factory _$_BasketProduct.fromJson(Map<String, dynamic> json) =>
      _$$_BasketProductFromJson(json);

  @override
  final int quantity;
  @override
  final Product product;

  @override
  String toString() {
    return 'BasketProduct(quantity: $quantity, product: $product)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BasketProduct &&
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
  _$$_BasketProductCopyWith<_$_BasketProduct> get copyWith =>
      __$$_BasketProductCopyWithImpl<_$_BasketProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BasketProductToJson(
      this,
    );
  }
}

abstract class _BasketProduct implements BasketProduct {
  const factory _BasketProduct(
      {required final int quantity,
      required final Product product}) = _$_BasketProduct;

  factory _BasketProduct.fromJson(Map<String, dynamic> json) =
      _$_BasketProduct.fromJson;

  @override
  int get quantity;
  @override
  Product get product;
  @override
  @JsonKey(ignore: true)
  _$$_BasketProductCopyWith<_$_BasketProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
