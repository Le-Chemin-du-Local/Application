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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Basket _$BasketFromJson(Map<String, dynamic> json) {
  return _Basket.fromJson(json);
}

/// @nodoc
mixin _$Basket {
  List<BasketCommerce> get commerces => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
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
abstract class _$$_BasketCopyWith<$Res> implements $BasketCopyWith<$Res> {
  factory _$$_BasketCopyWith(_$_Basket value, $Res Function(_$_Basket) then) =
      __$$_BasketCopyWithImpl<$Res>;
  @override
  $Res call({List<BasketCommerce> commerces});
}

/// @nodoc
class __$$_BasketCopyWithImpl<$Res> extends _$BasketCopyWithImpl<$Res>
    implements _$$_BasketCopyWith<$Res> {
  __$$_BasketCopyWithImpl(_$_Basket _value, $Res Function(_$_Basket) _then)
      : super(_value, (v) => _then(v as _$_Basket));

  @override
  _$_Basket get _value => super._value as _$_Basket;

  @override
  $Res call({
    Object? commerces = freezed,
  }) {
    return _then(_$_Basket(
      commerces: commerces == freezed
          ? _value._commerces
          : commerces // ignore: cast_nullable_to_non_nullable
              as List<BasketCommerce>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Basket extends _Basket {
  const _$_Basket(
      {final List<BasketCommerce> commerces = const <BasketCommerce>[]})
      : _commerces = commerces,
        super._();

  factory _$_Basket.fromJson(Map<String, dynamic> json) =>
      _$$_BasketFromJson(json);

  final List<BasketCommerce> _commerces;
  @override
  @JsonKey()
  List<BasketCommerce> get commerces {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commerces);
  }

  @override
  String toString() {
    return 'Basket(commerces: $commerces)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Basket &&
            const DeepCollectionEquality()
                .equals(other._commerces, _commerces));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_commerces));

  @JsonKey(ignore: true)
  @override
  _$$_BasketCopyWith<_$_Basket> get copyWith =>
      __$$_BasketCopyWithImpl<_$_Basket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BasketToJson(
      this,
    );
  }
}

abstract class _Basket extends Basket {
  const factory _Basket({final List<BasketCommerce> commerces}) = _$_Basket;
  const _Basket._() : super._();

  factory _Basket.fromJson(Map<String, dynamic> json) = _$_Basket.fromJson;

  @override
  List<BasketCommerce> get commerces;
  @override
  @JsonKey(ignore: true)
  _$$_BasketCopyWith<_$_Basket> get copyWith =>
      throw _privateConstructorUsedError;
}
