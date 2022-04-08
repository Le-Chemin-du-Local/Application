// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'panier_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PanierCommand _$PanierCommandFromJson(Map<String, dynamic> json) {
  return _PanierCommand.fromJson(json);
}

/// @nodoc
class _$PanierCommandTearOff {
  const _$PanierCommandTearOff();

  _PanierCommand call(String? id,
      {required String status,
      required DateTime pickupDate,
      required Panier panier,
      User? user}) {
    return _PanierCommand(
      id,
      status: status,
      pickupDate: pickupDate,
      panier: panier,
      user: user,
    );
  }

  PanierCommand fromJson(Map<String, Object?> json) {
    return PanierCommand.fromJson(json);
  }
}

/// @nodoc
const $PanierCommand = _$PanierCommandTearOff();

/// @nodoc
mixin _$PanierCommand {
  String? get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get pickupDate => throw _privateConstructorUsedError;
  Panier get panier => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PanierCommandCopyWith<PanierCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PanierCommandCopyWith<$Res> {
  factory $PanierCommandCopyWith(
          PanierCommand value, $Res Function(PanierCommand) then) =
      _$PanierCommandCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String status,
      DateTime pickupDate,
      Panier panier,
      User? user});

  $PanierCopyWith<$Res> get panier;
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$PanierCommandCopyWithImpl<$Res>
    implements $PanierCommandCopyWith<$Res> {
  _$PanierCommandCopyWithImpl(this._value, this._then);

  final PanierCommand _value;
  // ignore: unused_field
  final $Res Function(PanierCommand) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? pickupDate = freezed,
    Object? panier = freezed,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      pickupDate: pickupDate == freezed
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      panier: panier == freezed
          ? _value.panier
          : panier // ignore: cast_nullable_to_non_nullable
              as Panier,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }

  @override
  $PanierCopyWith<$Res> get panier {
    return $PanierCopyWith<$Res>(_value.panier, (value) {
      return _then(_value.copyWith(panier: value));
    });
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
abstract class _$PanierCommandCopyWith<$Res>
    implements $PanierCommandCopyWith<$Res> {
  factory _$PanierCommandCopyWith(
          _PanierCommand value, $Res Function(_PanierCommand) then) =
      __$PanierCommandCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String status,
      DateTime pickupDate,
      Panier panier,
      User? user});

  @override
  $PanierCopyWith<$Res> get panier;
  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$PanierCommandCopyWithImpl<$Res>
    extends _$PanierCommandCopyWithImpl<$Res>
    implements _$PanierCommandCopyWith<$Res> {
  __$PanierCommandCopyWithImpl(
      _PanierCommand _value, $Res Function(_PanierCommand) _then)
      : super(_value, (v) => _then(v as _PanierCommand));

  @override
  _PanierCommand get _value => super._value as _PanierCommand;

  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? pickupDate = freezed,
    Object? panier = freezed,
    Object? user = freezed,
  }) {
    return _then(_PanierCommand(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      pickupDate: pickupDate == freezed
          ? _value.pickupDate
          : pickupDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      panier: panier == freezed
          ? _value.panier
          : panier // ignore: cast_nullable_to_non_nullable
              as Panier,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PanierCommand with DiagnosticableTreeMixin implements _PanierCommand {
  const _$_PanierCommand(this.id,
      {required this.status,
      required this.pickupDate,
      required this.panier,
      this.user});

  factory _$_PanierCommand.fromJson(Map<String, dynamic> json) =>
      _$$_PanierCommandFromJson(json);

  @override
  final String? id;
  @override
  final String status;
  @override
  final DateTime pickupDate;
  @override
  final Panier panier;
  @override
  final User? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierCommand(id: $id, status: $status, pickupDate: $pickupDate, panier: $panier, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PanierCommand'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('pickupDate', pickupDate))
      ..add(DiagnosticsProperty('panier', panier))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PanierCommand &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.pickupDate, pickupDate) &&
            const DeepCollectionEquality().equals(other.panier, panier) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(pickupDate),
      const DeepCollectionEquality().hash(panier),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$PanierCommandCopyWith<_PanierCommand> get copyWith =>
      __$PanierCommandCopyWithImpl<_PanierCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PanierCommandToJson(this);
  }
}

abstract class _PanierCommand implements PanierCommand {
  const factory _PanierCommand(String? id,
      {required String status,
      required DateTime pickupDate,
      required Panier panier,
      User? user}) = _$_PanierCommand;

  factory _PanierCommand.fromJson(Map<String, dynamic> json) =
      _$_PanierCommand.fromJson;

  @override
  String? get id;
  @override
  String get status;
  @override
  DateTime get pickupDate;
  @override
  Panier get panier;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$PanierCommandCopyWith<_PanierCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
