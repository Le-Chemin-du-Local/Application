// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'commerce.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Commerce _$CommerceFromJson(Map<String, dynamic> json) {
  return _Commerce.fromJson(json);
}

/// @nodoc
class _$CommerceTearOff {
  const _$CommerceTearOff();

  _Commerce call(String? id,
      {required String name,
      List<String> categories = const <String>[],
      String? description,
      String? address,
      String? phone,
      String? email}) {
    return _Commerce(
      id,
      name: name,
      categories: categories,
      description: description,
      address: address,
      phone: phone,
      email: email,
    );
  }

  Commerce fromJson(Map<String, Object?> json) {
    return Commerce.fromJson(json);
  }
}

/// @nodoc
const $Commerce = _$CommerceTearOff();

/// @nodoc
mixin _$Commerce {
  String? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommerceCopyWith<Commerce> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommerceCopyWith<$Res> {
  factory $CommerceCopyWith(Commerce value, $Res Function(Commerce) then) =
      _$CommerceCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String name,
      List<String> categories,
      String? description,
      String? address,
      String? phone,
      String? email});
}

/// @nodoc
class _$CommerceCopyWithImpl<$Res> implements $CommerceCopyWith<$Res> {
  _$CommerceCopyWithImpl(this._value, this._then);

  final Commerce _value;
  // ignore: unused_field
  final $Res Function(Commerce) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? categories = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$CommerceCopyWith<$Res> implements $CommerceCopyWith<$Res> {
  factory _$CommerceCopyWith(_Commerce value, $Res Function(_Commerce) then) =
      __$CommerceCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String name,
      List<String> categories,
      String? description,
      String? address,
      String? phone,
      String? email});
}

/// @nodoc
class __$CommerceCopyWithImpl<$Res> extends _$CommerceCopyWithImpl<$Res>
    implements _$CommerceCopyWith<$Res> {
  __$CommerceCopyWithImpl(_Commerce _value, $Res Function(_Commerce) _then)
      : super(_value, (v) => _then(v as _Commerce));

  @override
  _Commerce get _value => super._value as _Commerce;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? categories = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
  }) {
    return _then(_Commerce(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Commerce with DiagnosticableTreeMixin implements _Commerce {
  const _$_Commerce(this.id,
      {required this.name,
      this.categories = const <String>[],
      this.description,
      this.address,
      this.phone,
      this.email});

  factory _$_Commerce.fromJson(Map<String, dynamic> json) =>
      _$$_CommerceFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @JsonKey()
  @override
  final List<String> categories;
  @override
  final String? description;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Commerce(id: $id, name: $name, categories: $categories, description: $description, address: $address, phone: $phone, email: $email)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Commerce'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('email', email));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Commerce &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.email, email));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(categories),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(email));

  @JsonKey(ignore: true)
  @override
  _$CommerceCopyWith<_Commerce> get copyWith =>
      __$CommerceCopyWithImpl<_Commerce>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommerceToJson(this);
  }
}

abstract class _Commerce implements Commerce {
  const factory _Commerce(String? id,
      {required String name,
      List<String> categories,
      String? description,
      String? address,
      String? phone,
      String? email}) = _$_Commerce;

  factory _Commerce.fromJson(Map<String, dynamic> json) = _$_Commerce.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  List<String> get categories;
  @override
  String? get description;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  @JsonKey(ignore: true)
  _$CommerceCopyWith<_Commerce> get copyWith =>
      throw _privateConstructorUsedError;
}
