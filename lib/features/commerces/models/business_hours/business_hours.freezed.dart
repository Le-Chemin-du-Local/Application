// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'business_hours.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusinessHours _$BusinessHoursFromJson(Map<String, dynamic> json) {
  return _BusinessHours.fromJson(json);
}

/// @nodoc
mixin _$BusinessHours {
  List<Schedule>? get monday => throw _privateConstructorUsedError;
  List<Schedule>? get tuesday => throw _privateConstructorUsedError;
  List<Schedule>? get wednesday => throw _privateConstructorUsedError;
  List<Schedule>? get thursday => throw _privateConstructorUsedError;
  List<Schedule>? get friday => throw _privateConstructorUsedError;
  List<Schedule>? get saturday => throw _privateConstructorUsedError;
  List<Schedule>? get sunday => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusinessHoursCopyWith<BusinessHours> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessHoursCopyWith<$Res> {
  factory $BusinessHoursCopyWith(
          BusinessHours value, $Res Function(BusinessHours) then) =
      _$BusinessHoursCopyWithImpl<$Res>;
  $Res call(
      {List<Schedule>? monday,
      List<Schedule>? tuesday,
      List<Schedule>? wednesday,
      List<Schedule>? thursday,
      List<Schedule>? friday,
      List<Schedule>? saturday,
      List<Schedule>? sunday});
}

/// @nodoc
class _$BusinessHoursCopyWithImpl<$Res>
    implements $BusinessHoursCopyWith<$Res> {
  _$BusinessHoursCopyWithImpl(this._value, this._then);

  final BusinessHours _value;
  // ignore: unused_field
  final $Res Function(BusinessHours) _then;

  @override
  $Res call({
    Object? monday = freezed,
    Object? tuesday = freezed,
    Object? wednesday = freezed,
    Object? thursday = freezed,
    Object? friday = freezed,
    Object? saturday = freezed,
    Object? sunday = freezed,
  }) {
    return _then(_value.copyWith(
      monday: monday == freezed
          ? _value.monday
          : monday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      tuesday: tuesday == freezed
          ? _value.tuesday
          : tuesday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      wednesday: wednesday == freezed
          ? _value.wednesday
          : wednesday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      thursday: thursday == freezed
          ? _value.thursday
          : thursday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      friday: friday == freezed
          ? _value.friday
          : friday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      saturday: saturday == freezed
          ? _value.saturday
          : saturday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      sunday: sunday == freezed
          ? _value.sunday
          : sunday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
    ));
  }
}

/// @nodoc
abstract class _$$_BusinessHoursCopyWith<$Res>
    implements $BusinessHoursCopyWith<$Res> {
  factory _$$_BusinessHoursCopyWith(
          _$_BusinessHours value, $Res Function(_$_BusinessHours) then) =
      __$$_BusinessHoursCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Schedule>? monday,
      List<Schedule>? tuesday,
      List<Schedule>? wednesday,
      List<Schedule>? thursday,
      List<Schedule>? friday,
      List<Schedule>? saturday,
      List<Schedule>? sunday});
}

/// @nodoc
class __$$_BusinessHoursCopyWithImpl<$Res>
    extends _$BusinessHoursCopyWithImpl<$Res>
    implements _$$_BusinessHoursCopyWith<$Res> {
  __$$_BusinessHoursCopyWithImpl(
      _$_BusinessHours _value, $Res Function(_$_BusinessHours) _then)
      : super(_value, (v) => _then(v as _$_BusinessHours));

  @override
  _$_BusinessHours get _value => super._value as _$_BusinessHours;

  @override
  $Res call({
    Object? monday = freezed,
    Object? tuesday = freezed,
    Object? wednesday = freezed,
    Object? thursday = freezed,
    Object? friday = freezed,
    Object? saturday = freezed,
    Object? sunday = freezed,
  }) {
    return _then(_$_BusinessHours(
      monday: monday == freezed
          ? _value.monday
          : monday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      tuesday: tuesday == freezed
          ? _value.tuesday
          : tuesday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      wednesday: wednesday == freezed
          ? _value.wednesday
          : wednesday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      thursday: thursday == freezed
          ? _value.thursday
          : thursday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      friday: friday == freezed
          ? _value.friday
          : friday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      saturday: saturday == freezed
          ? _value.saturday
          : saturday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
      sunday: sunday == freezed
          ? _value.sunday
          : sunday // ignore: cast_nullable_to_non_nullable
              as List<Schedule>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BusinessHours extends _BusinessHours with DiagnosticableTreeMixin {
  const _$_BusinessHours(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday})
      : super._();

  factory _$_BusinessHours.fromJson(Map<String, dynamic> json) =>
      _$$_BusinessHoursFromJson(json);

  @override
  final List<Schedule>? monday;
  @override
  final List<Schedule>? tuesday;
  @override
  final List<Schedule>? wednesday;
  @override
  final List<Schedule>? thursday;
  @override
  final List<Schedule>? friday;
  @override
  final List<Schedule>? saturday;
  @override
  final List<Schedule>? sunday;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BusinessHours(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BusinessHours'))
      ..add(DiagnosticsProperty('monday', monday))
      ..add(DiagnosticsProperty('tuesday', tuesday))
      ..add(DiagnosticsProperty('wednesday', wednesday))
      ..add(DiagnosticsProperty('thursday', thursday))
      ..add(DiagnosticsProperty('friday', friday))
      ..add(DiagnosticsProperty('saturday', saturday))
      ..add(DiagnosticsProperty('sunday', sunday));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BusinessHours &&
            const DeepCollectionEquality().equals(other.monday, monday) &&
            const DeepCollectionEquality().equals(other.tuesday, tuesday) &&
            const DeepCollectionEquality().equals(other.wednesday, wednesday) &&
            const DeepCollectionEquality().equals(other.thursday, thursday) &&
            const DeepCollectionEquality().equals(other.friday, friday) &&
            const DeepCollectionEquality().equals(other.saturday, saturday) &&
            const DeepCollectionEquality().equals(other.sunday, sunday));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(monday),
      const DeepCollectionEquality().hash(tuesday),
      const DeepCollectionEquality().hash(wednesday),
      const DeepCollectionEquality().hash(thursday),
      const DeepCollectionEquality().hash(friday),
      const DeepCollectionEquality().hash(saturday),
      const DeepCollectionEquality().hash(sunday));

  @JsonKey(ignore: true)
  @override
  _$$_BusinessHoursCopyWith<_$_BusinessHours> get copyWith =>
      __$$_BusinessHoursCopyWithImpl<_$_BusinessHours>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BusinessHoursToJson(this);
  }
}

abstract class _BusinessHours extends BusinessHours {
  const factory _BusinessHours(
      {final List<Schedule>? monday,
      final List<Schedule>? tuesday,
      final List<Schedule>? wednesday,
      final List<Schedule>? thursday,
      final List<Schedule>? friday,
      final List<Schedule>? saturday,
      final List<Schedule>? sunday}) = _$_BusinessHours;
  const _BusinessHours._() : super._();

  factory _BusinessHours.fromJson(Map<String, dynamic> json) =
      _$_BusinessHours.fromJson;

  @override
  List<Schedule>? get monday => throw _privateConstructorUsedError;
  @override
  List<Schedule>? get tuesday => throw _privateConstructorUsedError;
  @override
  List<Schedule>? get wednesday => throw _privateConstructorUsedError;
  @override
  List<Schedule>? get thursday => throw _privateConstructorUsedError;
  @override
  List<Schedule>? get friday => throw _privateConstructorUsedError;
  @override
  List<Schedule>? get saturday => throw _privateConstructorUsedError;
  @override
  List<Schedule>? get sunday => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_BusinessHoursCopyWith<_$_BusinessHours> get copyWith =>
      throw _privateConstructorUsedError;
}
