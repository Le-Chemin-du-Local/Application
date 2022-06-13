// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cl_payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClPaymentMethod _$ClPaymentMethodFromJson(Map<String, dynamic> json) {
  return _ClPaymentMethod.fromJson(json);
}

/// @nodoc
mixin _$ClPaymentMethod {
  String? get name => throw _privateConstructorUsedError;
  String? get stripeID => throw _privateConstructorUsedError;
  String? get cardBrand => throw _privateConstructorUsedError;
  String? get cardLast4Digits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClPaymentMethodCopyWith<ClPaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClPaymentMethodCopyWith<$Res> {
  factory $ClPaymentMethodCopyWith(
          ClPaymentMethod value, $Res Function(ClPaymentMethod) then) =
      _$ClPaymentMethodCopyWithImpl<$Res>;
  $Res call(
      {String? name,
      String? stripeID,
      String? cardBrand,
      String? cardLast4Digits});
}

/// @nodoc
class _$ClPaymentMethodCopyWithImpl<$Res>
    implements $ClPaymentMethodCopyWith<$Res> {
  _$ClPaymentMethodCopyWithImpl(this._value, this._then);

  final ClPaymentMethod _value;
  // ignore: unused_field
  final $Res Function(ClPaymentMethod) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? stripeID = freezed,
    Object? cardBrand = freezed,
    Object? cardLast4Digits = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      stripeID: stripeID == freezed
          ? _value.stripeID
          : stripeID // ignore: cast_nullable_to_non_nullable
              as String?,
      cardBrand: cardBrand == freezed
          ? _value.cardBrand
          : cardBrand // ignore: cast_nullable_to_non_nullable
              as String?,
      cardLast4Digits: cardLast4Digits == freezed
          ? _value.cardLast4Digits
          : cardLast4Digits // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ClPaymentMethodCopyWith<$Res>
    implements $ClPaymentMethodCopyWith<$Res> {
  factory _$$_ClPaymentMethodCopyWith(
          _$_ClPaymentMethod value, $Res Function(_$_ClPaymentMethod) then) =
      __$$_ClPaymentMethodCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? name,
      String? stripeID,
      String? cardBrand,
      String? cardLast4Digits});
}

/// @nodoc
class __$$_ClPaymentMethodCopyWithImpl<$Res>
    extends _$ClPaymentMethodCopyWithImpl<$Res>
    implements _$$_ClPaymentMethodCopyWith<$Res> {
  __$$_ClPaymentMethodCopyWithImpl(
      _$_ClPaymentMethod _value, $Res Function(_$_ClPaymentMethod) _then)
      : super(_value, (v) => _then(v as _$_ClPaymentMethod));

  @override
  _$_ClPaymentMethod get _value => super._value as _$_ClPaymentMethod;

  @override
  $Res call({
    Object? name = freezed,
    Object? stripeID = freezed,
    Object? cardBrand = freezed,
    Object? cardLast4Digits = freezed,
  }) {
    return _then(_$_ClPaymentMethod(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      stripeID: stripeID == freezed
          ? _value.stripeID
          : stripeID // ignore: cast_nullable_to_non_nullable
              as String?,
      cardBrand: cardBrand == freezed
          ? _value.cardBrand
          : cardBrand // ignore: cast_nullable_to_non_nullable
              as String?,
      cardLast4Digits: cardLast4Digits == freezed
          ? _value.cardLast4Digits
          : cardLast4Digits // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClPaymentMethod
    with DiagnosticableTreeMixin
    implements _ClPaymentMethod {
  const _$_ClPaymentMethod(
      {this.name, this.stripeID, this.cardBrand, this.cardLast4Digits});

  factory _$_ClPaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$$_ClPaymentMethodFromJson(json);

  @override
  final String? name;
  @override
  final String? stripeID;
  @override
  final String? cardBrand;
  @override
  final String? cardLast4Digits;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClPaymentMethod(name: $name, stripeID: $stripeID, cardBrand: $cardBrand, cardLast4Digits: $cardLast4Digits)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClPaymentMethod'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('stripeID', stripeID))
      ..add(DiagnosticsProperty('cardBrand', cardBrand))
      ..add(DiagnosticsProperty('cardLast4Digits', cardLast4Digits));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClPaymentMethod &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.stripeID, stripeID) &&
            const DeepCollectionEquality().equals(other.cardBrand, cardBrand) &&
            const DeepCollectionEquality()
                .equals(other.cardLast4Digits, cardLast4Digits));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(stripeID),
      const DeepCollectionEquality().hash(cardBrand),
      const DeepCollectionEquality().hash(cardLast4Digits));

  @JsonKey(ignore: true)
  @override
  _$$_ClPaymentMethodCopyWith<_$_ClPaymentMethod> get copyWith =>
      __$$_ClPaymentMethodCopyWithImpl<_$_ClPaymentMethod>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClPaymentMethodToJson(this);
  }
}

abstract class _ClPaymentMethod implements ClPaymentMethod {
  const factory _ClPaymentMethod(
      {final String? name,
      final String? stripeID,
      final String? cardBrand,
      final String? cardLast4Digits}) = _$_ClPaymentMethod;

  factory _ClPaymentMethod.fromJson(Map<String, dynamic> json) =
      _$_ClPaymentMethod.fromJson;

  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get stripeID => throw _privateConstructorUsedError;
  @override
  String? get cardBrand => throw _privateConstructorUsedError;
  @override
  String? get cardLast4Digits => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_ClPaymentMethodCopyWith<_$_ClPaymentMethod> get copyWith =>
      throw _privateConstructorUsedError;
}
