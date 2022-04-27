// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return _Schedule.fromJson(json);
}

/// @nodoc
class _$ScheduleTearOff {
  const _$ScheduleTearOff();

  _Schedule call({required String opening, required String closing}) {
    return _Schedule(
      opening: opening,
      closing: closing,
    );
  }

  Schedule fromJson(Map<String, Object?> json) {
    return Schedule.fromJson(json);
  }
}

/// @nodoc
const $Schedule = _$ScheduleTearOff();

/// @nodoc
mixin _$Schedule {
  String get opening => throw _privateConstructorUsedError;
  String get closing => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleCopyWith<Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleCopyWith<$Res> {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) then) =
      _$ScheduleCopyWithImpl<$Res>;
  $Res call({String opening, String closing});
}

/// @nodoc
class _$ScheduleCopyWithImpl<$Res> implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._value, this._then);

  final Schedule _value;
  // ignore: unused_field
  final $Res Function(Schedule) _then;

  @override
  $Res call({
    Object? opening = freezed,
    Object? closing = freezed,
  }) {
    return _then(_value.copyWith(
      opening: opening == freezed
          ? _value.opening
          : opening // ignore: cast_nullable_to_non_nullable
              as String,
      closing: closing == freezed
          ? _value.closing
          : closing // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory _$ScheduleCopyWith(_Schedule value, $Res Function(_Schedule) then) =
      __$ScheduleCopyWithImpl<$Res>;
  @override
  $Res call({String opening, String closing});
}

/// @nodoc
class __$ScheduleCopyWithImpl<$Res> extends _$ScheduleCopyWithImpl<$Res>
    implements _$ScheduleCopyWith<$Res> {
  __$ScheduleCopyWithImpl(_Schedule _value, $Res Function(_Schedule) _then)
      : super(_value, (v) => _then(v as _Schedule));

  @override
  _Schedule get _value => super._value as _Schedule;

  @override
  $Res call({
    Object? opening = freezed,
    Object? closing = freezed,
  }) {
    return _then(_Schedule(
      opening: opening == freezed
          ? _value.opening
          : opening // ignore: cast_nullable_to_non_nullable
              as String,
      closing: closing == freezed
          ? _value.closing
          : closing // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Schedule with DiagnosticableTreeMixin implements _Schedule {
  const _$_Schedule({required this.opening, required this.closing});

  factory _$_Schedule.fromJson(Map<String, dynamic> json) =>
      _$$_ScheduleFromJson(json);

  @override
  final String opening;
  @override
  final String closing;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Schedule(opening: $opening, closing: $closing)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Schedule'))
      ..add(DiagnosticsProperty('opening', opening))
      ..add(DiagnosticsProperty('closing', closing));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Schedule &&
            const DeepCollectionEquality().equals(other.opening, opening) &&
            const DeepCollectionEquality().equals(other.closing, closing));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(opening),
      const DeepCollectionEquality().hash(closing));

  @JsonKey(ignore: true)
  @override
  _$ScheduleCopyWith<_Schedule> get copyWith =>
      __$ScheduleCopyWithImpl<_Schedule>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScheduleToJson(this);
  }
}

abstract class _Schedule implements Schedule {
  const factory _Schedule({required String opening, required String closing}) =
      _$_Schedule;

  factory _Schedule.fromJson(Map<String, dynamic> json) = _$_Schedule.fromJson;

  @override
  String get opening;
  @override
  String get closing;
  @override
  @JsonKey(ignore: true)
  _$ScheduleCopyWith<_Schedule> get copyWith =>
      throw _privateConstructorUsedError;
}
