// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'ccproduct.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CCProduct _$CCProductFromJson(Map<String, dynamic> json) {
  return _CCProduct.fromJson(json);
}

/// @nodoc
mixin _$CCProduct {
  int get quantity => throw _privateConstructorUsedError;
  Product get product => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CCProductCopyWith<CCProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CCProductCopyWith<$Res> {
  factory $CCProductCopyWith(CCProduct value, $Res Function(CCProduct) then) =
      _$CCProductCopyWithImpl<$Res>;
  $Res call({int quantity, Product product});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$CCProductCopyWithImpl<$Res> implements $CCProductCopyWith<$Res> {
  _$CCProductCopyWithImpl(this._value, this._then);

  final CCProduct _value;
  // ignore: unused_field
  final $Res Function(CCProduct) _then;

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
abstract class _$$_CCProductCopyWith<$Res> implements $CCProductCopyWith<$Res> {
  factory _$$_CCProductCopyWith(
          _$_CCProduct value, $Res Function(_$_CCProduct) then) =
      __$$_CCProductCopyWithImpl<$Res>;
  @override
  $Res call({int quantity, Product product});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$_CCProductCopyWithImpl<$Res> extends _$CCProductCopyWithImpl<$Res>
    implements _$$_CCProductCopyWith<$Res> {
  __$$_CCProductCopyWithImpl(
      _$_CCProduct _value, $Res Function(_$_CCProduct) _then)
      : super(_value, (v) => _then(v as _$_CCProduct));

  @override
  _$_CCProduct get _value => super._value as _$_CCProduct;

  @override
  $Res call({
    Object? quantity = freezed,
    Object? product = freezed,
  }) {
    return _then(_$_CCProduct(
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
class _$_CCProduct with DiagnosticableTreeMixin implements _CCProduct {
  const _$_CCProduct({required this.quantity, required this.product});

  factory _$_CCProduct.fromJson(Map<String, dynamic> json) =>
      _$$_CCProductFromJson(json);

  @override
  final int quantity;
  @override
  final Product product;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CCProduct(quantity: $quantity, product: $product)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CCProduct'))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('product', product));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CCProduct &&
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
  _$$_CCProductCopyWith<_$_CCProduct> get copyWith =>
      __$$_CCProductCopyWithImpl<_$_CCProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CCProductToJson(this);
  }
}

abstract class _CCProduct implements CCProduct {
  const factory _CCProduct(
      {required final int quantity,
      required final Product product}) = _$_CCProduct;

  factory _CCProduct.fromJson(Map<String, dynamic> json) =
      _$_CCProduct.fromJson;

  @override
  int get quantity => throw _privateConstructorUsedError;
  @override
  Product get product => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CCProductCopyWith<_$_CCProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
