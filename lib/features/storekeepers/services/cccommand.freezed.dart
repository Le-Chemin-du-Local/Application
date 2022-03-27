// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cccommand.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CCCommand _$CCCommandFromJson(Map<String, dynamic> json) {
  return _CCCommand.fromJson(json);
}

/// @nodoc
class _$CCCommandTearOff {
  const _$CCCommandTearOff();

  _CCCommand call(String? id,
      {required String status,
      required DateTime pickupDate,
      List<CCProduct> products = const <CCProduct>[],
      User? user}) {
    return _CCCommand(
      id,
      status: status,
      pickupDate: pickupDate,
      products: products,
      user: user,
    );
  }

  CCCommand fromJson(Map<String, Object?> json) {
    return CCCommand.fromJson(json);
  }
}

/// @nodoc
const $CCCommand = _$CCCommandTearOff();

/// @nodoc
mixin _$CCCommand {
  String? get id => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get pickupDate => throw _privateConstructorUsedError;
  List<CCProduct> get products => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CCCommandCopyWith<CCCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CCCommandCopyWith<$Res> {
  factory $CCCommandCopyWith(CCCommand value, $Res Function(CCCommand) then) =
      _$CCCommandCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String status,
      DateTime pickupDate,
      List<CCProduct> products,
      User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$CCCommandCopyWithImpl<$Res> implements $CCCommandCopyWith<$Res> {
  _$CCCommandCopyWithImpl(this._value, this._then);

  final CCCommand _value;
  // ignore: unused_field
  final $Res Function(CCCommand) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? pickupDate = freezed,
    Object? products = freezed,
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
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<CCProduct>,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
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
abstract class _$CCCommandCopyWith<$Res> implements $CCCommandCopyWith<$Res> {
  factory _$CCCommandCopyWith(
          _CCCommand value, $Res Function(_CCCommand) then) =
      __$CCCommandCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String status,
      DateTime pickupDate,
      List<CCProduct> products,
      User? user});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$CCCommandCopyWithImpl<$Res> extends _$CCCommandCopyWithImpl<$Res>
    implements _$CCCommandCopyWith<$Res> {
  __$CCCommandCopyWithImpl(_CCCommand _value, $Res Function(_CCCommand) _then)
      : super(_value, (v) => _then(v as _CCCommand));

  @override
  _CCCommand get _value => super._value as _CCCommand;

  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? pickupDate = freezed,
    Object? products = freezed,
    Object? user = freezed,
  }) {
    return _then(_CCCommand(
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
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<CCProduct>,
      user: user == freezed
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CCCommand with DiagnosticableTreeMixin implements _CCCommand {
  const _$_CCCommand(this.id,
      {required this.status,
      required this.pickupDate,
      this.products = const <CCProduct>[],
      this.user});

  factory _$_CCCommand.fromJson(Map<String, dynamic> json) =>
      _$$_CCCommandFromJson(json);

  @override
  final String? id;
  @override
  final String status;
  @override
  final DateTime pickupDate;
  @JsonKey()
  @override
  final List<CCProduct> products;
  @override
  final User? user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CCCommand(id: $id, status: $status, pickupDate: $pickupDate, products: $products, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CCCommand'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('pickupDate', pickupDate))
      ..add(DiagnosticsProperty('products', products))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CCCommand &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.pickupDate, pickupDate) &&
            const DeepCollectionEquality().equals(other.products, products) &&
            const DeepCollectionEquality().equals(other.user, user));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(pickupDate),
      const DeepCollectionEquality().hash(products),
      const DeepCollectionEquality().hash(user));

  @JsonKey(ignore: true)
  @override
  _$CCCommandCopyWith<_CCCommand> get copyWith =>
      __$CCCommandCopyWithImpl<_CCCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CCCommandToJson(this);
  }
}

abstract class _CCCommand implements CCCommand {
  const factory _CCCommand(String? id,
      {required String status,
      required DateTime pickupDate,
      List<CCProduct> products,
      User? user}) = _$_CCCommand;

  factory _CCCommand.fromJson(Map<String, dynamic> json) =
      _$_CCCommand.fromJson;

  @override
  String? get id;
  @override
  String get status;
  @override
  DateTime get pickupDate;
  @override
  List<CCProduct> get products;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$CCCommandCopyWith<_CCCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
