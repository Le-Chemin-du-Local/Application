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
      User? storekeeper,
      List<String> categories = const <String>[],
      List<String> services = const <String>[],
      String? storekeeperWord,
      String? description,
      String? address,
      String? phone,
      String? email,
      String? facebook,
      String? twitter,
      String? instagram,
      double? latitude,
      double? longitude}) {
    return _Commerce(
      id,
      name: name,
      storekeeper: storekeeper,
      categories: categories,
      services: services,
      storekeeperWord: storekeeperWord,
      description: description,
      address: address,
      phone: phone,
      email: email,
      facebook: facebook,
      twitter: twitter,
      instagram: instagram,
      latitude: latitude,
      longitude: longitude,
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
  User? get storekeeper => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<String> get services => throw _privateConstructorUsedError;
  String? get storekeeperWord => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get facebook => throw _privateConstructorUsedError;
  String? get twitter => throw _privateConstructorUsedError;
  String? get instagram => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

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
      User? storekeeper,
      List<String> categories,
      List<String> services,
      String? storekeeperWord,
      String? description,
      String? address,
      String? phone,
      String? email,
      String? facebook,
      String? twitter,
      String? instagram,
      double? latitude,
      double? longitude});

  $UserCopyWith<$Res>? get storekeeper;
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
    Object? storekeeper = freezed,
    Object? categories = freezed,
    Object? services = freezed,
    Object? storekeeperWord = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? facebook = freezed,
    Object? twitter = freezed,
    Object? instagram = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
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
      storekeeper: storekeeper == freezed
          ? _value.storekeeper
          : storekeeper // ignore: cast_nullable_to_non_nullable
              as User?,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>,
      storekeeperWord: storekeeperWord == freezed
          ? _value.storekeeperWord
          : storekeeperWord // ignore: cast_nullable_to_non_nullable
              as String?,
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
      facebook: facebook == freezed
          ? _value.facebook
          : facebook // ignore: cast_nullable_to_non_nullable
              as String?,
      twitter: twitter == freezed
          ? _value.twitter
          : twitter // ignore: cast_nullable_to_non_nullable
              as String?,
      instagram: instagram == freezed
          ? _value.instagram
          : instagram // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }

  @override
  $UserCopyWith<$Res>? get storekeeper {
    if (_value.storekeeper == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.storekeeper!, (value) {
      return _then(_value.copyWith(storekeeper: value));
    });
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
      User? storekeeper,
      List<String> categories,
      List<String> services,
      String? storekeeperWord,
      String? description,
      String? address,
      String? phone,
      String? email,
      String? facebook,
      String? twitter,
      String? instagram,
      double? latitude,
      double? longitude});

  @override
  $UserCopyWith<$Res>? get storekeeper;
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
    Object? storekeeper = freezed,
    Object? categories = freezed,
    Object? services = freezed,
    Object? storekeeperWord = freezed,
    Object? description = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? facebook = freezed,
    Object? twitter = freezed,
    Object? instagram = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
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
      storekeeper: storekeeper == freezed
          ? _value.storekeeper
          : storekeeper // ignore: cast_nullable_to_non_nullable
              as User?,
      categories: categories == freezed
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<String>,
      storekeeperWord: storekeeperWord == freezed
          ? _value.storekeeperWord
          : storekeeperWord // ignore: cast_nullable_to_non_nullable
              as String?,
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
      facebook: facebook == freezed
          ? _value.facebook
          : facebook // ignore: cast_nullable_to_non_nullable
              as String?,
      twitter: twitter == freezed
          ? _value.twitter
          : twitter // ignore: cast_nullable_to_non_nullable
              as String?,
      instagram: instagram == freezed
          ? _value.instagram
          : instagram // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Commerce with DiagnosticableTreeMixin implements _Commerce {
  const _$_Commerce(this.id,
      {required this.name,
      this.storekeeper,
      this.categories = const <String>[],
      this.services = const <String>[],
      this.storekeeperWord,
      this.description,
      this.address,
      this.phone,
      this.email,
      this.facebook,
      this.twitter,
      this.instagram,
      this.latitude,
      this.longitude});

  factory _$_Commerce.fromJson(Map<String, dynamic> json) =>
      _$$_CommerceFromJson(json);

  @override
  final String? id;
  @override
  final String name;
  @override
  final User? storekeeper;
  @JsonKey()
  @override
  final List<String> categories;
  @JsonKey()
  @override
  final List<String> services;
  @override
  final String? storekeeperWord;
  @override
  final String? description;
  @override
  final String? address;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? facebook;
  @override
  final String? twitter;
  @override
  final String? instagram;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Commerce(id: $id, name: $name, storekeeper: $storekeeper, categories: $categories, services: $services, storekeeperWord: $storekeeperWord, description: $description, address: $address, phone: $phone, email: $email, facebook: $facebook, twitter: $twitter, instagram: $instagram, latitude: $latitude, longitude: $longitude)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Commerce'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('storekeeper', storekeeper))
      ..add(DiagnosticsProperty('categories', categories))
      ..add(DiagnosticsProperty('services', services))
      ..add(DiagnosticsProperty('storekeeperWord', storekeeperWord))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('address', address))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('facebook', facebook))
      ..add(DiagnosticsProperty('twitter', twitter))
      ..add(DiagnosticsProperty('instagram', instagram))
      ..add(DiagnosticsProperty('latitude', latitude))
      ..add(DiagnosticsProperty('longitude', longitude));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Commerce &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.storekeeper, storekeeper) &&
            const DeepCollectionEquality()
                .equals(other.categories, categories) &&
            const DeepCollectionEquality().equals(other.services, services) &&
            const DeepCollectionEquality()
                .equals(other.storekeeperWord, storekeeperWord) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.facebook, facebook) &&
            const DeepCollectionEquality().equals(other.twitter, twitter) &&
            const DeepCollectionEquality().equals(other.instagram, instagram) &&
            const DeepCollectionEquality().equals(other.latitude, latitude) &&
            const DeepCollectionEquality().equals(other.longitude, longitude));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(storekeeper),
      const DeepCollectionEquality().hash(categories),
      const DeepCollectionEquality().hash(services),
      const DeepCollectionEquality().hash(storekeeperWord),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(facebook),
      const DeepCollectionEquality().hash(twitter),
      const DeepCollectionEquality().hash(instagram),
      const DeepCollectionEquality().hash(latitude),
      const DeepCollectionEquality().hash(longitude));

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
      User? storekeeper,
      List<String> categories,
      List<String> services,
      String? storekeeperWord,
      String? description,
      String? address,
      String? phone,
      String? email,
      String? facebook,
      String? twitter,
      String? instagram,
      double? latitude,
      double? longitude}) = _$_Commerce;

  factory _Commerce.fromJson(Map<String, dynamic> json) = _$_Commerce.fromJson;

  @override
  String? get id;
  @override
  String get name;
  @override
  User? get storekeeper;
  @override
  List<String> get categories;
  @override
  List<String> get services;
  @override
  String? get storekeeperWord;
  @override
  String? get description;
  @override
  String? get address;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  String? get facebook;
  @override
  String? get twitter;
  @override
  String? get instagram;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  @JsonKey(ignore: true)
  _$CommerceCopyWith<_Commerce> get copyWith =>
      throw _privateConstructorUsedError;
}
