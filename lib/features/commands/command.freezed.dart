// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Command _$CommandFromJson(Map<String, dynamic> json) {
  return _Command.fromJson(json);
}

/// @nodoc
mixin _$Command {
  String? get id => throw _privateConstructorUsedError;
  DateTime? get creationDate => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  List<CommerceCommand> get commerces => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommandCopyWith<Command> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommandCopyWith<$Res> {
  factory $CommandCopyWith(Command value, $Res Function(Command) then) =
      _$CommandCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      DateTime? creationDate,
      User? user,
      List<CommerceCommand> commerces,
      String? status});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CommandCopyWithImpl<$Res> implements $CommandCopyWith<$Res> {
  _$CommandCopyWithImpl(this._value, this._then);

  final Command _value;
  // ignore: unused_field
  final $Res Function(Command) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? creationDate = freezed,
    Object? user = freezed,
    Object? commerces = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      creationDate: creationDate == freezed
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      commerces: commerces == freezed
          ? _value.commerces
          : commerces // ignore: cast_nullable_to_non_nullable
              as List<CommerceCommand>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  @override
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
abstract class _$$_CommandCopyWith<$Res> implements $CommandCopyWith<$Res> {
  factory _$$_CommandCopyWith(
          _$_Command value, $Res Function(_$_Command) then) =
      __$$_CommandCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      DateTime? creationDate,
      User? user,
      List<CommerceCommand> commerces,
      String? status});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_CommandCopyWithImpl<$Res> extends _$CommandCopyWithImpl<$Res>
    implements _$$_CommandCopyWith<$Res> {
  __$$_CommandCopyWithImpl(_$_Command _value, $Res Function(_$_Command) _then)
      : super(_value, (v) => _then(v as _$_Command));

  @override
  _$_Command get _value => super._value as _$_Command;

  @override
  $Res call({
    Object? id = freezed,
    Object? creationDate = freezed,
    Object? user = freezed,
    Object? commerces = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_Command(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      creationDate: creationDate == freezed
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      commerces: commerces == freezed
          ? _value._commerces
          : commerces // ignore: cast_nullable_to_non_nullable
              as List<CommerceCommand>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Command with DiagnosticableTreeMixin implements _Command {
  const _$_Command(this.id,
      {this.creationDate,
      this.user,
      final List<CommerceCommand> commerces = const <CommerceCommand>[],
      this.status})
      : _commerces = commerces;

  factory _$_Command.fromJson(Map<String, dynamic> json) =>
      _$$_CommandFromJson(json);

  @override
  final String? id;
  @override
  final DateTime? creationDate;
  @override
  final User? user;
  final List<CommerceCommand> _commerces;
  @override
  @JsonKey()
  List<CommerceCommand> get commerces {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commerces);
  }

  @override
  final String? status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Command(id: $id, creationDate: $creationDate, user: $user, commerces: $commerces, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Command'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('creationDate', creationDate))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('commerces', commerces))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Command &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.creationDate, creationDate) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality()
                .equals(other._commerces, _commerces) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(creationDate),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(_commerces),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_CommandCopyWith<_$_Command> get copyWith =>
      __$$_CommandCopyWithImpl<_$_Command>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommandToJson(this);
  }
}

abstract class _Command implements Command {
  const factory _Command(final String? id,
      {final DateTime? creationDate,
      final User? user,
      final List<CommerceCommand> commerces,
      final String? status}) = _$_Command;

  factory _Command.fromJson(Map<String, dynamic> json) = _$_Command.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  DateTime? get creationDate => throw _privateConstructorUsedError;
  @override
  User? get user => throw _privateConstructorUsedError;
  @override
  List<CommerceCommand> get commerces => throw _privateConstructorUsedError;
  @override
  String? get status => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CommandCopyWith<_$_Command> get copyWith =>
      throw _privateConstructorUsedError;
}
