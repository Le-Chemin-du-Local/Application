// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'panier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Panier _$PanierFromJson(Map<String, dynamic> json) {
  return _PanierProduct.fromJson(json);
}

/// @nodoc
class _$PanierTearOff {
  const _$PanierTearOff();

  _PanierProduct call(String? id,
      {required String name,
      required String category,
      String description = "",
      int quantity = 0,
      double price = 0,
      List<PanierProduct> products = const <PanierProduct>[]}) {
    return _PanierProduct(
      id,
      name: name,
      category: category,
      description: description,
      quantity: quantity,
      price: price,
      products: products,
    );
  }

  Panier fromJson(Map<String, Object?> json) {
    return Panier.fromJson(json);
  }
}

/// @nodoc
const $Panier = _$PanierTearOff();

/// @nodoc
mixin _$Panier {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  List<PanierProduct> get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PanierCopyWith<Panier> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanierCopyWith<$Res> {
  factory $PanierCopyWith(Panier value, $Res Function(Panier) then) =
      _$PanierCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String name,
      String category,
      String description,
      int quantity,
      double price,
      List<PanierProduct> products});
}

/// @nodoc
class _$PanierCopyWithImpl<$Res> implements $PanierCopyWith<$Res> {
  _$PanierCopyWithImpl(this._value, this._then);

  final Panier _value;
  // ignore: unused_field
  final $Res Function(Panier) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? description = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? products = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<PanierProduct>,
    ));
  }
}

/// @nodoc
abstract class _$PanierProductCopyWith<$Res> implements $PanierCopyWith<$Res> {
  factory _$PanierProductCopyWith(
          _PanierProduct value, $Res Function(_PanierProduct) then) =
      __$PanierProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String name,
      String category,
      String description,
      int quantity,
      double price,
      List<PanierProduct> products});
}

/// @nodoc
class __$PanierProductCopyWithImpl<$Res> extends _$PanierCopyWithImpl<$Res>
    implements _$PanierProductCopyWith<$Res> {
  __$PanierProductCopyWithImpl(
      _PanierProduct _value, $Res Function(_PanierProduct) _then)
      : super(_value, (v) => _then(v as _PanierProduct));

  @override
  _PanierProduct get _value => super._value as _PanierProduct;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? category = freezed,
    Object? description = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? products = freezed,
  }) {
    return _then(_PanierProduct(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: quantity == freezed
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<PanierProduct>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PanierProduct with DiagnosticableTreeMixin implements _PanierProduct {
  const _$_PanierProduct(this.id,
      {required this.name,
      required this.category,
      this.description = "",
      this.quantity = 0,
      this.price = 0,
      this.products = const <PanierProduct>[]});

  factory _$_PanierProduct.fromJson(Map<String, dynamic> json) =>
      _$$_PanierProductFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String category;
  @JsonKey()
  @override
  final String description;
  @JsonKey()
  @override
  final int quantity;
  @JsonKey()
  @override
  final double price;
  @JsonKey()
  @override
  final List<PanierProduct> products;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Panier(id: $id, name: $name, category: $category, description: $description, quantity: $quantity, price: $price, products: $products)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Panier'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('quantity', quantity))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('products', products));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PanierProduct &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.products, products));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(products));

  @JsonKey(ignore: true)
  @override
  _$PanierProductCopyWith<_PanierProduct> get copyWith =>
      __$PanierProductCopyWithImpl<_PanierProduct>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PanierProductToJson(this);
  }
}

abstract class _PanierProduct implements Panier {
  const factory _PanierProduct(String? id,
      {required String name,
      required String category,
      String description,
      int quantity,
      double price,
      List<PanierProduct> products}) = _$_PanierProduct;

  factory _PanierProduct.fromJson(Map<String, dynamic> json) =
      _$_PanierProduct.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String get description;
  @override
  int get quantity;
  @override
  double get price;
  @override
  List<PanierProduct> get products;
  @override
  @JsonKey(ignore: true)
  _$PanierProductCopyWith<_PanierProduct> get copyWith =>
      throw _privateConstructorUsedError;
}