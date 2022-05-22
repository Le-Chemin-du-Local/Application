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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CCCommand _$CCCommandFromJson(Map<String, dynamic> json) {
  return _CCCommand.fromJson(json);
}

/// @nodoc
mixin _$CCCommand {
  String? get id => throw _privateConstructorUsedError;
  List<CCProduct> get products => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CCCommandCopyWith<CCCommand> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CCCommandCopyWith<$Res> {
  factory $CCCommandCopyWith(CCCommand value, $Res Function(CCCommand) then) =
      _$CCCommandCopyWithImpl<$Res>;
  $Res call({String? id, List<CCProduct> products});
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
    Object? products = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<CCProduct>,
    ));
  }
}

/// @nodoc
abstract class _$$_CCCommandCopyWith<$Res> implements $CCCommandCopyWith<$Res> {
  factory _$$_CCCommandCopyWith(
          _$_CCCommand value, $Res Function(_$_CCCommand) then) =
      __$$_CCCommandCopyWithImpl<$Res>;
  @override
  $Res call({String? id, List<CCProduct> products});
}

/// @nodoc
class __$$_CCCommandCopyWithImpl<$Res> extends _$CCCommandCopyWithImpl<$Res>
    implements _$$_CCCommandCopyWith<$Res> {
  __$$_CCCommandCopyWithImpl(
      _$_CCCommand _value, $Res Function(_$_CCCommand) _then)
      : super(_value, (v) => _then(v as _$_CCCommand));

  @override
  _$_CCCommand get _value => super._value as _$_CCCommand;

  @override
  $Res call({
    Object? id = freezed,
    Object? products = freezed,
  }) {
    return _then(_$_CCCommand(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      products: products == freezed
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<CCProduct>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CCCommand with DiagnosticableTreeMixin implements _CCCommand {
  const _$_CCCommand(this.id,
      {final List<CCProduct> products = const <CCProduct>[]})
      : _products = products;

  factory _$_CCCommand.fromJson(Map<String, dynamic> json) =>
      _$$_CCCommandFromJson(json);

  @override
  final String? id;
  final List<CCProduct> _products;
  @override
  @JsonKey()
  List<CCProduct> get products {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CCCommand(id: $id, products: $products)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CCCommand'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('products', products));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CCCommand &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  _$$_CCCommandCopyWith<_$_CCCommand> get copyWith =>
      __$$_CCCommandCopyWithImpl<_$_CCCommand>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CCCommandToJson(this);
  }
}

abstract class _CCCommand implements CCCommand {
  const factory _CCCommand(final String? id, {final List<CCProduct> products}) =
      _$_CCCommand;

  factory _CCCommand.fromJson(Map<String, dynamic> json) =
      _$_CCCommand.fromJson;

  @override
  String? get id => throw _privateConstructorUsedError;
  @override
  List<CCProduct> get products => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CCCommandCopyWith<_$_CCCommand> get copyWith =>
      throw _privateConstructorUsedError;
}
