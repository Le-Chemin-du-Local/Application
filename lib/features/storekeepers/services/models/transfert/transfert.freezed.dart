// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transfert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Transfert _$TransfertFromJson(Map<String, dynamic> json) {
  return _Transfert.fromJson(json);
}

/// @nodoc
mixin _$Transfert {
  double get value => throw _privateConstructorUsedError;
  String get ibanOwner => throw _privateConstructorUsedError;
  String get iban => throw _privateConstructorUsedError;
  String get bic => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransfertCopyWith<Transfert> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransfertCopyWith<$Res> {
  factory $TransfertCopyWith(Transfert value, $Res Function(Transfert) then) =
      _$TransfertCopyWithImpl<$Res>;
  $Res call({double value, String ibanOwner, String iban, String bic});
}

/// @nodoc
class _$TransfertCopyWithImpl<$Res> implements $TransfertCopyWith<$Res> {
  _$TransfertCopyWithImpl(this._value, this._then);

  final Transfert _value;
  // ignore: unused_field
  final $Res Function(Transfert) _then;

  @override
  $Res call({
    Object? value = freezed,
    Object? ibanOwner = freezed,
    Object? iban = freezed,
    Object? bic = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      ibanOwner: ibanOwner == freezed
          ? _value.ibanOwner
          : ibanOwner // ignore: cast_nullable_to_non_nullable
              as String,
      iban: iban == freezed
          ? _value.iban
          : iban // ignore: cast_nullable_to_non_nullable
              as String,
      bic: bic == freezed
          ? _value.bic
          : bic // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TransfertCopyWith<$Res> implements $TransfertCopyWith<$Res> {
  factory _$$_TransfertCopyWith(
          _$_Transfert value, $Res Function(_$_Transfert) then) =
      __$$_TransfertCopyWithImpl<$Res>;
  @override
  $Res call({double value, String ibanOwner, String iban, String bic});
}

/// @nodoc
class __$$_TransfertCopyWithImpl<$Res> extends _$TransfertCopyWithImpl<$Res>
    implements _$$_TransfertCopyWith<$Res> {
  __$$_TransfertCopyWithImpl(
      _$_Transfert _value, $Res Function(_$_Transfert) _then)
      : super(_value, (v) => _then(v as _$_Transfert));

  @override
  _$_Transfert get _value => super._value as _$_Transfert;

  @override
  $Res call({
    Object? value = freezed,
    Object? ibanOwner = freezed,
    Object? iban = freezed,
    Object? bic = freezed,
  }) {
    return _then(_$_Transfert(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      ibanOwner: ibanOwner == freezed
          ? _value.ibanOwner
          : ibanOwner // ignore: cast_nullable_to_non_nullable
              as String,
      iban: iban == freezed
          ? _value.iban
          : iban // ignore: cast_nullable_to_non_nullable
              as String,
      bic: bic == freezed
          ? _value.bic
          : bic // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transfert with DiagnosticableTreeMixin implements _Transfert {
  const _$_Transfert(
      {required this.value,
      required this.ibanOwner,
      required this.iban,
      required this.bic});

  factory _$_Transfert.fromJson(Map<String, dynamic> json) =>
      _$$_TransfertFromJson(json);

  @override
  final double value;
  @override
  final String ibanOwner;
  @override
  final String iban;
  @override
  final String bic;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Transfert(value: $value, ibanOwner: $ibanOwner, iban: $iban, bic: $bic)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Transfert'))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('ibanOwner', ibanOwner))
      ..add(DiagnosticsProperty('iban', iban))
      ..add(DiagnosticsProperty('bic', bic));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transfert &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.ibanOwner, ibanOwner) &&
            const DeepCollectionEquality().equals(other.iban, iban) &&
            const DeepCollectionEquality().equals(other.bic, bic));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(ibanOwner),
      const DeepCollectionEquality().hash(iban),
      const DeepCollectionEquality().hash(bic));

  @JsonKey(ignore: true)
  @override
  _$$_TransfertCopyWith<_$_Transfert> get copyWith =>
      __$$_TransfertCopyWithImpl<_$_Transfert>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransfertToJson(this);
  }
}

abstract class _Transfert implements Transfert {
  const factory _Transfert(
      {required final double value,
      required final String ibanOwner,
      required final String iban,
      required final String bic}) = _$_Transfert;

  factory _Transfert.fromJson(Map<String, dynamic> json) =
      _$_Transfert.fromJson;

  @override
  double get value => throw _privateConstructorUsedError;
  @override
  String get ibanOwner => throw _privateConstructorUsedError;
  @override
  String get iban => throw _privateConstructorUsedError;
  @override
  String get bic => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_TransfertCopyWith<_$_Transfert> get copyWith =>
      throw _privateConstructorUsedError;
}
