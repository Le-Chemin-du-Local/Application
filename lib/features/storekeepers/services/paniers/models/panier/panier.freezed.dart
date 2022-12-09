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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Panier _$PanierFromJson(Map<String, dynamic> json) {
  return _PanierProduct.fromJson(json);
}

/// @nodoc
mixin _$Panier {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get reduction => throw _privateConstructorUsedError;
  List<PanierProduct> get products => throw _privateConstructorUsedError;
  DateTime? get endingDate => throw _privateConstructorUsedError;

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
      String type,
      String category,
      String description,
      int quantity,
      double price,
      double reduction,
      List<PanierProduct> products,
      DateTime? endingDate});
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
    Object? type = freezed,
    Object? category = freezed,
    Object? description = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? reduction = freezed,
    Object? products = freezed,
    Object? endingDate = freezed,
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
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
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
      reduction: reduction == freezed
          ? _value.reduction
          : reduction // ignore: cast_nullable_to_non_nullable
              as double,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<PanierProduct>,
      endingDate: endingDate == freezed
          ? _value.endingDate
          : endingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$$_PanierProductCopyWith<$Res>
    implements $PanierCopyWith<$Res> {
  factory _$$_PanierProductCopyWith(
          _$_PanierProduct value, $Res Function(_$_PanierProduct) then) =
      __$$_PanierProductCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String name,
      String type,
      String category,
      String description,
      int quantity,
      double price,
      double reduction,
      List<PanierProduct> products,
      DateTime? endingDate});
}

/// @nodoc
class __$$_PanierProductCopyWithImpl<$Res> extends _$PanierCopyWithImpl<$Res>
    implements _$$_PanierProductCopyWith<$Res> {
  __$$_PanierProductCopyWithImpl(
      _$_PanierProduct _value, $Res Function(_$_PanierProduct) _then)
      : super(_value, (v) => _then(v as _$_PanierProduct));

  @override
  _$_PanierProduct get _value => super._value as _$_PanierProduct;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? category = freezed,
    Object? description = freezed,
    Object? quantity = freezed,
    Object? price = freezed,
    Object? reduction = freezed,
    Object? products = freezed,
    Object? endingDate = freezed,
  }) {
    return _then(_$_PanierProduct(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
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
      reduction: reduction == freezed
          ? _value.reduction
          : reduction // ignore: cast_nullable_to_non_nullable
              as double,
      products: products == freezed
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<PanierProduct>,
      endingDate: endingDate == freezed
          ? _value.endingDate
          : endingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PanierProduct implements _PanierProduct {
  const _$_PanierProduct(this.id,
      {required this.name,
      required this.type,
      this.category = "Autre",
      this.description = "",
      this.quantity = 0,
      this.price = 0,
      this.reduction = 0,
      final List<PanierProduct> products = const <PanierProduct>[],
      this.endingDate})
      : _products = products;

  factory _$_PanierProduct.fromJson(Map<String, dynamic> json) =>
      _$$_PanierProductFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final String type;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final int quantity;
  @override
  @JsonKey()
  final double price;
  @override
  @JsonKey()
  final double reduction;
  final List<PanierProduct> _products;
  @override
  @JsonKey()
  List<PanierProduct> get products {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  final DateTime? endingDate;

  @override
  String toString() {
    return 'Panier(id: $id, name: $name, type: $type, category: $category, description: $description, quantity: $quantity, price: $price, reduction: $reduction, products: $products, endingDate: $endingDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PanierProduct &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.quantity, quantity) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality().equals(other.reduction, reduction) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other.endingDate, endingDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(quantity),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(reduction),
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(endingDate));

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

abstract class _PanierProduct implements Panier {
  const factory _PanierProduct(final String? id,
      {required final String name,
      required final String type,
      final String category,
      final String description,
      final int quantity,
      final double price,
      final double reduction,
      final List<PanierProduct> products,
      final DateTime? endingDate}) = _$_PanierProduct;

  factory _PanierProduct.fromJson(Map<String, dynamic> json) =
      _$_PanierProduct.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get category;
  @override
  String get description;
  @override
  int get quantity;
  @override
  double get price;
  @override
  double get reduction;
  @override
  List<PanierProduct> get products;
  @override
  DateTime? get endingDate;
  @override
  @JsonKey(ignore: true)
  _$$_PanierProductCopyWith<_$_PanierProduct> get copyWith =>
      throw _privateConstructorUsedError;
}
