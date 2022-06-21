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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PanierCommand _$PanierCommandFromJson(Map<String, dynamic> json) {
  return _PanierCommand.fromJson(json);
}

/// @nodoc
mixin _$PanierCommand {
  String? get id => throw _privateConstructorUsedError;
  Panier get panier => throw _privateConstructorUsedError;

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
  $Res call({String? id, Panier panier});

  $PanierCopyWith<$Res> get panier;
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
    Object? panier = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      panier: panier == freezed
          ? _value.panier
          : panier // ignore: cast_nullable_to_non_nullable
              as Panier,
    ));
  }

  @override
  $PanierCopyWith<$Res> get panier {
    return $PanierCopyWith<$Res>(_value.panier, (value) {
      return _then(_value.copyWith(panier: value));
    });
  }
}

/// @nodoc
abstract class _$$_PanierCommandCopyWith<$Res>
    implements $PanierCommandCopyWith<$Res> {
  factory _$$_PanierCommandCopyWith(
          _$_PanierCommand value, $Res Function(_$_PanierCommand) then) =
      __$$_PanierCommandCopyWithImpl<$Res>;
  @override
  $Res call({String? id, Panier panier});

  @override
  $PanierCopyWith<$Res> get panier;
}

/// @nodoc
class __$$_PanierCommandCopyWithImpl<$Res>
    extends _$PanierCommandCopyWithImpl<$Res>
    implements _$$_PanierCommandCopyWith<$Res> {
  __$$_PanierCommandCopyWithImpl(
      _$_PanierCommand _value, $Res Function(_$_PanierCommand) _then)
      : super(_value, (v) => _then(v as _$_PanierCommand));

  @override
  _$_PanierCommand get _value => super._value as _$_PanierCommand;

  @override
  $Res call({
    Object? id = freezed,
    Object? panier = freezed,
  }) {
    return _then(_$_PanierCommand(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      panier: panier == freezed
          ? _value.panier
          : panier // ignore: cast_nullable_to_non_nullable
              as Panier,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PanierCommand with DiagnosticableTreeMixin implements _PanierCommand {
  const _$_PanierCommand(this.id, {required this.panier});

  factory _$_PanierCommand.fromJson(Map<String, dynamic> json) =>
      _$$_PanierCommandFromJson(json);

  @override
  final String? id;
  @override
  final Panier panier;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PanierCommand(id: $id, panier: $panier)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PanierCommand'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('panier', panier));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PanierCommand &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.panier, panier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(panier));

  @JsonKey(ignore: true)
  @override
  _$$_PanierCommandCopyWith<_$_PanierCommand> get copyWith =>
      __$$_PanierCommandCopyWithImpl<_$_PanierCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PanierCommandToJson(this);
  }
}

abstract class _PanierCommand implements PanierCommand {
  const factory _PanierCommand(final String? id,
      {required final Panier panier}) = _$_PanierCommand;

  factory _PanierCommand.fromJson(Map<String, dynamic> json) =
      _$_PanierCommand.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  Panier get panier => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_PanierCommandCopyWith<_$_PanierCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
