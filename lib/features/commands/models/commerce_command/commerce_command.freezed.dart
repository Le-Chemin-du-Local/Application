// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'commerce_command.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CommerceCommand _$CommerceCommandFromJson(Map<String, dynamic> json) {
  return _CommerceCommand.fromJson(json);
}

/// @nodoc
mixin _$CommerceCommand {
  String? get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime? get pickupDate => throw _privateConstructorUsedError;
  Commerce? get commerce => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  List<CCCommand> get cccommands => throw _privateConstructorUsedError;
  @JsonKey(name: "paniers")
  List<PanierCommand> get panierCommands => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommerceCommandCopyWith<CommerceCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommerceCommandCopyWith<$Res> {
  factory $CommerceCommandCopyWith(
          CommerceCommand value, $Res Function(CommerceCommand) then) =
      _$CommerceCommandCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String status,
      DateTime? pickupDate,
      Commerce? commerce,
      User? user,
      double? price,
      List<CCCommand> cccommands,
      @JsonKey(name: "paniers") List<PanierCommand> panierCommands});

  $CommerceCopyWith<$Res>? get commerce;
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CommerceCommandCopyWithImpl<$Res>
    implements $CommerceCommandCopyWith<$Res> {
  _$CommerceCommandCopyWithImpl(this._value, this._then);

  final CommerceCommand _value;
  // ignore: unused_field
  final $Res Function(CommerceCommand) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? pickupDate = freezed,
    Object? commerce = freezed,
    Object? user = freezed,
    Object? price = freezed,
    Object? cccommands = freezed,
    Object? panierCommands = freezed,
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
              as DateTime?,
      commerce: commerce == freezed
          ? _value.commerce
          : commerce // ignore: cast_nullable_to_non_nullable
              as Commerce?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      cccommands: cccommands == freezed
          ? _value.cccommands
          : cccommands // ignore: cast_nullable_to_non_nullable
              as List<CCCommand>,
      panierCommands: panierCommands == freezed
          ? _value.panierCommands
          : panierCommands // ignore: cast_nullable_to_non_nullable
              as List<PanierCommand>,
    ));
  }

  @override
  $CommerceCopyWith<$Res>? get commerce {
    if (_value.commerce == null) {
      return null;
    }

    return $CommerceCopyWith<$Res>(_value.commerce!, (value) {
      return _then(_value.copyWith(commerce: value));
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
abstract class _$$_CommerceCommandCopyWith<$Res>
    implements $CommerceCommandCopyWith<$Res> {
  factory _$$_CommerceCommandCopyWith(
          _$_CommerceCommand value, $Res Function(_$_CommerceCommand) then) =
      __$$_CommerceCommandCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String status,
      DateTime? pickupDate,
      Commerce? commerce,
      User? user,
      double? price,
      List<CCCommand> cccommands,
      @JsonKey(name: "paniers") List<PanierCommand> panierCommands});

  @override
  $CommerceCopyWith<$Res>? get commerce;
  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_CommerceCommandCopyWithImpl<$Res>
    extends _$CommerceCommandCopyWithImpl<$Res>
    implements _$$_CommerceCommandCopyWith<$Res> {
  __$$_CommerceCommandCopyWithImpl(
      _$_CommerceCommand _value, $Res Function(_$_CommerceCommand) _then)
      : super(_value, (v) => _then(v as _$_CommerceCommand));

  @override
  _$_CommerceCommand get _value => super._value as _$_CommerceCommand;

  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? pickupDate = freezed,
    Object? commerce = freezed,
    Object? user = freezed,
    Object? price = freezed,
    Object? cccommands = freezed,
    Object? panierCommands = freezed,
  }) {
    return _then(_$_CommerceCommand(
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
              as DateTime?,
      commerce: commerce == freezed
          ? _value.commerce
          : commerce // ignore: cast_nullable_to_non_nullable
              as Commerce?,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      cccommands: cccommands == freezed
          ? _value._cccommands
          : cccommands // ignore: cast_nullable_to_non_nullable
              as List<CCCommand>,
      panierCommands: panierCommands == freezed
          ? _value._panierCommands
          : panierCommands // ignore: cast_nullable_to_non_nullable
              as List<PanierCommand>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CommerceCommand
    with DiagnosticableTreeMixin
    implements _CommerceCommand {
  const _$_CommerceCommand(
      this.id,
      {required this.status,
      this.pickupDate,
      this.commerce,
      this.user,
      this.price,
      final List<CCCommand> cccommands = const <CCCommand>[],
      @JsonKey(name: "paniers")
          final List<PanierCommand> panierCommands = const <PanierCommand>[]})
      : _cccommands = cccommands,
        _panierCommands = panierCommands;

  factory _$_CommerceCommand.fromJson(Map<String, dynamic> json) =>
      _$$_CommerceCommandFromJson(json);

  @override
  final String? id;
  @override
  final String status;
  @override
  final DateTime? pickupDate;
  @override
  final Commerce? commerce;
  @override
  final User? user;
  @override
  final double? price;
  final List<CCCommand> _cccommands;
  @override
  @JsonKey()
  List<CCCommand> get cccommands {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cccommands);
  }

  final List<PanierCommand> _panierCommands;
  @override
  @JsonKey(name: "paniers")
  List<PanierCommand> get panierCommands {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_panierCommands);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CommerceCommand(id: $id, status: $status, pickupDate: $pickupDate, commerce: $commerce, user: $user, price: $price, cccommands: $cccommands, panierCommands: $panierCommands)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CommerceCommand'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('pickupDate', pickupDate))
      ..add(DiagnosticsProperty('commerce', commerce))
      ..add(DiagnosticsProperty('user', user))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('cccommands', cccommands))
      ..add(DiagnosticsProperty('panierCommands', panierCommands));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommerceCommand &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.pickupDate, pickupDate) &&
            const DeepCollectionEquality().equals(other.commerce, commerce) &&
            const DeepCollectionEquality().equals(other.user, user) &&
            const DeepCollectionEquality().equals(other.price, price) &&
            const DeepCollectionEquality()
                .equals(other._cccommands, _cccommands) &&
            const DeepCollectionEquality()
                .equals(other._panierCommands, _panierCommands));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(pickupDate),
      const DeepCollectionEquality().hash(commerce),
      const DeepCollectionEquality().hash(user),
      const DeepCollectionEquality().hash(price),
      const DeepCollectionEquality().hash(_cccommands),
      const DeepCollectionEquality().hash(_panierCommands));

  @JsonKey(ignore: true)
  @override
  _$$_CommerceCommandCopyWith<_$_CommerceCommand> get copyWith =>
      __$$_CommerceCommandCopyWithImpl<_$_CommerceCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommerceCommandToJson(this);
  }
}

abstract class _CommerceCommand implements CommerceCommand {
  const factory _CommerceCommand(final String? id,
          {required final String status,
          final DateTime? pickupDate,
          final Commerce? commerce,
          final User? user,
          final double? price,
          final List<CCCommand> cccommands,
          @JsonKey(name: "paniers") final List<PanierCommand> panierCommands}) =
      _$_CommerceCommand;

  factory _CommerceCommand.fromJson(Map<String, dynamic> json) =
      _$_CommerceCommand.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  String get status => throw _privateConstructorUsedError;
  @override
  DateTime? get pickupDate => throw _privateConstructorUsedError;
  @override
  Commerce? get commerce => throw _privateConstructorUsedError;
  @override
  User? get user => throw _privateConstructorUsedError;
  @override
  double? get price => throw _privateConstructorUsedError;
  @override
  List<CCCommand> get cccommands => throw _privateConstructorUsedError;
  @override
  @JsonKey(name: "paniers")
  List<PanierCommand> get panierCommands => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CommerceCommandCopyWith<_$_CommerceCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
