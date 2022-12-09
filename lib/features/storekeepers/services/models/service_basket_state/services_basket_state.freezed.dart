// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'services_basket_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ServicesBasketState {
  List<Tuple2<ServiceInfo, ServiceType>> get services =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ServicesBasketStateCopyWith<ServicesBasketState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServicesBasketStateCopyWith<$Res> {
  factory $ServicesBasketStateCopyWith(
          ServicesBasketState value, $Res Function(ServicesBasketState) then) =
      _$ServicesBasketStateCopyWithImpl<$Res>;
  $Res call({List<Tuple2<ServiceInfo, ServiceType>> services});
}

/// @nodoc
class _$ServicesBasketStateCopyWithImpl<$Res>
    implements $ServicesBasketStateCopyWith<$Res> {
  _$ServicesBasketStateCopyWithImpl(this._value, this._then);

  final ServicesBasketState _value;
  // ignore: unused_field
  final $Res Function(ServicesBasketState) _then;

  @override
  $Res call({
    Object? services = freezed,
  }) {
    return _then(_value.copyWith(
      services: services == freezed
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<Tuple2<ServiceInfo, ServiceType>>,
    ));
  }
}

/// @nodoc
abstract class _$$_ServicesBasketStateCopyWith<$Res>
    implements $ServicesBasketStateCopyWith<$Res> {
  factory _$$_ServicesBasketStateCopyWith(_$_ServicesBasketState value,
          $Res Function(_$_ServicesBasketState) then) =
      __$$_ServicesBasketStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Tuple2<ServiceInfo, ServiceType>> services});
}

/// @nodoc
class __$$_ServicesBasketStateCopyWithImpl<$Res>
    extends _$ServicesBasketStateCopyWithImpl<$Res>
    implements _$$_ServicesBasketStateCopyWith<$Res> {
  __$$_ServicesBasketStateCopyWithImpl(_$_ServicesBasketState _value,
      $Res Function(_$_ServicesBasketState) _then)
      : super(_value, (v) => _then(v as _$_ServicesBasketState));

  @override
  _$_ServicesBasketState get _value => super._value as _$_ServicesBasketState;

  @override
  $Res call({
    Object? services = freezed,
  }) {
    return _then(_$_ServicesBasketState(
      services: services == freezed
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<Tuple2<ServiceInfo, ServiceType>>,
    ));
  }
}

/// @nodoc

class _$_ServicesBasketState extends _ServicesBasketState {
  const _$_ServicesBasketState(
      {required final List<Tuple2<ServiceInfo, ServiceType>> services})
      : _services = services,
        super._();

  final List<Tuple2<ServiceInfo, ServiceType>> _services;
  @override
  List<Tuple2<ServiceInfo, ServiceType>> get services {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  String toString() {
    return 'ServicesBasketState(services: $services)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ServicesBasketState &&
            const DeepCollectionEquality().equals(other._services, _services));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_services));

  @JsonKey(ignore: true)
  @override
  _$$_ServicesBasketStateCopyWith<_$_ServicesBasketState> get copyWith =>
      __$$_ServicesBasketStateCopyWithImpl<_$_ServicesBasketState>(
          this, _$identity);
}

abstract class _ServicesBasketState extends ServicesBasketState {
  const factory _ServicesBasketState(
          {required final List<Tuple2<ServiceInfo, ServiceType>> services}) =
      _$_ServicesBasketState;
  const _ServicesBasketState._() : super._();

  @override
  List<Tuple2<ServiceInfo, ServiceType>> get services;
  @override
  @JsonKey(ignore: true)
  _$$_ServicesBasketStateCopyWith<_$_ServicesBasketState> get copyWith =>
      throw _privateConstructorUsedError;
}
