// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'cl_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClFile _$ClFileFromJson(Map<String, dynamic> json) {
  return _ClFile.fromJson(json);
}

/// @nodoc
class _$ClFileTearOff {
  const _$ClFileTearOff();

  _ClFile call(
      {@JsonKey(name: "name") required String filename,
      @JsonKey(name: "content") String? base64content}) {
    return _ClFile(
      filename: filename,
      base64content: base64content,
    );
  }

  ClFile fromJson(Map<String, Object?> json) {
    return ClFile.fromJson(json);
  }
}

/// @nodoc
const $ClFile = _$ClFileTearOff();

/// @nodoc
mixin _$ClFile {
  @JsonKey(name: "name")
  String get filename => throw _privateConstructorUsedError;
  @JsonKey(name: "content")
  String? get base64content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClFileCopyWith<ClFile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClFileCopyWith<$Res> {
  factory $ClFileCopyWith(ClFile value, $Res Function(ClFile) then) =
      _$ClFileCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: "name") String filename,
      @JsonKey(name: "content") String? base64content});
}

/// @nodoc
class _$ClFileCopyWithImpl<$Res> implements $ClFileCopyWith<$Res> {
  _$ClFileCopyWithImpl(this._value, this._then);

  final ClFile _value;
  // ignore: unused_field
  final $Res Function(ClFile) _then;

  @override
  $Res call({
    Object? filename = freezed,
    Object? base64content = freezed,
  }) {
    return _then(_value.copyWith(
      filename: filename == freezed
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      base64content: base64content == freezed
          ? _value.base64content
          : base64content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ClFileCopyWith<$Res> implements $ClFileCopyWith<$Res> {
  factory _$ClFileCopyWith(_ClFile value, $Res Function(_ClFile) then) =
      __$ClFileCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: "name") String filename,
      @JsonKey(name: "content") String? base64content});
}

/// @nodoc
class __$ClFileCopyWithImpl<$Res> extends _$ClFileCopyWithImpl<$Res>
    implements _$ClFileCopyWith<$Res> {
  __$ClFileCopyWithImpl(_ClFile _value, $Res Function(_ClFile) _then)
      : super(_value, (v) => _then(v as _ClFile));

  @override
  _ClFile get _value => super._value as _ClFile;

  @override
  $Res call({
    Object? filename = freezed,
    Object? base64content = freezed,
  }) {
    return _then(_ClFile(
      filename: filename == freezed
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      base64content: base64content == freezed
          ? _value.base64content
          : base64content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClFile with DiagnosticableTreeMixin implements _ClFile {
  const _$_ClFile(
      {@JsonKey(name: "name") required this.filename,
      @JsonKey(name: "content") this.base64content});

  factory _$_ClFile.fromJson(Map<String, dynamic> json) =>
      _$$_ClFileFromJson(json);

  @override
  @JsonKey(name: "name")
  final String filename;
  @override
  @JsonKey(name: "content")
  final String? base64content;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClFile(filename: $filename, base64content: $base64content)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClFile'))
      ..add(DiagnosticsProperty('filename', filename))
      ..add(DiagnosticsProperty('base64content', base64content));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClFile &&
            const DeepCollectionEquality().equals(other.filename, filename) &&
            const DeepCollectionEquality()
                .equals(other.base64content, base64content));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(filename),
      const DeepCollectionEquality().hash(base64content));

  @JsonKey(ignore: true)
  @override
  _$ClFileCopyWith<_ClFile> get copyWith =>
      __$ClFileCopyWithImpl<_ClFile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClFileToJson(this);
  }
}

abstract class _ClFile implements ClFile {
  const factory _ClFile(
      {@JsonKey(name: "name") required String filename,
      @JsonKey(name: "content") String? base64content}) = _$_ClFile;

  factory _ClFile.fromJson(Map<String, dynamic> json) = _$_ClFile.fromJson;

  @override
  @JsonKey(name: "name")
  String get filename;
  @override
  @JsonKey(name: "content")
  String? get base64content;
  @override
  @JsonKey(ignore: true)
  _$ClFileCopyWith<_ClFile> get copyWith => throw _privateConstructorUsedError;
}
