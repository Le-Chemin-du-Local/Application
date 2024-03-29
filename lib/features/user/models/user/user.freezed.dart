// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String? get id => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  Commerce? get commerce => throw _privateConstructorUsedError;
  List<ClPaymentMethod> get registeredPaymentMethods =>
      throw _privateConstructorUsedError;
  ClPaymentMethod? get defaultPaymentMethod =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String role,
      String email,
      String? phone,
      String? firstName,
      String? lastName,
      DateTime? createdAt,
      Commerce? commerce,
      List<ClPaymentMethod> registeredPaymentMethods,
      ClPaymentMethod? defaultPaymentMethod});

  $CommerceCopyWith<$Res>? get commerce;
  $ClPaymentMethodCopyWith<$Res>? get defaultPaymentMethod;
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? role = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? createdAt = freezed,
    Object? commerce = freezed,
    Object? registeredPaymentMethods = freezed,
    Object? defaultPaymentMethod = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      commerce: commerce == freezed
          ? _value.commerce
          : commerce // ignore: cast_nullable_to_non_nullable
              as Commerce?,
      registeredPaymentMethods: registeredPaymentMethods == freezed
          ? _value.registeredPaymentMethods
          : registeredPaymentMethods // ignore: cast_nullable_to_non_nullable
              as List<ClPaymentMethod>,
      defaultPaymentMethod: defaultPaymentMethod == freezed
          ? _value.defaultPaymentMethod
          : defaultPaymentMethod // ignore: cast_nullable_to_non_nullable
              as ClPaymentMethod?,
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
  $ClPaymentMethodCopyWith<$Res>? get defaultPaymentMethod {
    if (_value.defaultPaymentMethod == null) {
      return null;
    }

    return $ClPaymentMethodCopyWith<$Res>(_value.defaultPaymentMethod!,
        (value) {
      return _then(_value.copyWith(defaultPaymentMethod: value));
    });
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String role,
      String email,
      String? phone,
      String? firstName,
      String? lastName,
      DateTime? createdAt,
      Commerce? commerce,
      List<ClPaymentMethod> registeredPaymentMethods,
      ClPaymentMethod? defaultPaymentMethod});

  @override
  $CommerceCopyWith<$Res>? get commerce;
  @override
  $ClPaymentMethodCopyWith<$Res>? get defaultPaymentMethod;
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, (v) => _then(v as _$_User));

  @override
  _$_User get _value => super._value as _$_User;

  @override
  $Res call({
    Object? id = freezed,
    Object? role = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? createdAt = freezed,
    Object? commerce = freezed,
    Object? registeredPaymentMethods = freezed,
    Object? defaultPaymentMethod = freezed,
  }) {
    return _then(_$_User(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      commerce: commerce == freezed
          ? _value.commerce
          : commerce // ignore: cast_nullable_to_non_nullable
              as Commerce?,
      registeredPaymentMethods: registeredPaymentMethods == freezed
          ? _value._registeredPaymentMethods
          : registeredPaymentMethods // ignore: cast_nullable_to_non_nullable
              as List<ClPaymentMethod>,
      defaultPaymentMethod: defaultPaymentMethod == freezed
          ? _value.defaultPaymentMethod
          : defaultPaymentMethod // ignore: cast_nullable_to_non_nullable
              as ClPaymentMethod?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  const _$_User(this.id,
      {required this.role,
      required this.email,
      this.phone,
      this.firstName,
      this.lastName,
      this.createdAt,
      this.commerce,
      final List<ClPaymentMethod> registeredPaymentMethods =
          const <ClPaymentMethod>[],
      this.defaultPaymentMethod})
      : _registeredPaymentMethods = registeredPaymentMethods;

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String? id;
  @override
  final String role;
  @override
  final String email;
  @override
  final String? phone;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final DateTime? createdAt;
  @override
  final Commerce? commerce;
  final List<ClPaymentMethod> _registeredPaymentMethods;
  @override
  @JsonKey()
  List<ClPaymentMethod> get registeredPaymentMethods {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_registeredPaymentMethods);
  }

  @override
  final ClPaymentMethod? defaultPaymentMethod;

  @override
  String toString() {
    return 'User(id: $id, role: $role, email: $email, phone: $phone, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, commerce: $commerce, registeredPaymentMethods: $registeredPaymentMethods, defaultPaymentMethod: $defaultPaymentMethod)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.role, role) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.commerce, commerce) &&
            const DeepCollectionEquality().equals(
                other._registeredPaymentMethods, _registeredPaymentMethods) &&
            const DeepCollectionEquality()
                .equals(other.defaultPaymentMethod, defaultPaymentMethod));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(role),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(commerce),
      const DeepCollectionEquality().hash(_registeredPaymentMethods),
      const DeepCollectionEquality().hash(defaultPaymentMethod));

  @JsonKey(ignore: true)
  @override
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(final String? id,
      {required final String role,
      required final String email,
      final String? phone,
      final String? firstName,
      final String? lastName,
      final DateTime? createdAt,
      final Commerce? commerce,
      final List<ClPaymentMethod> registeredPaymentMethods,
      final ClPaymentMethod? defaultPaymentMethod}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String? get id;
  @override
  String get role;
  @override
  String get email;
  @override
  String? get phone;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  DateTime? get createdAt;
  @override
  Commerce? get commerce;
  @override
  List<ClPaymentMethod> get registeredPaymentMethods;
  @override
  ClPaymentMethod? get defaultPaymentMethod;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
