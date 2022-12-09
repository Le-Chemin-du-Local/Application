// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'page_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PageItem {
  int get index => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get appBarTitle => throw _privateConstructorUsedError;
  bool get showOnMobile => throw _privateConstructorUsedError;
  IconData? get icon => throw _privateConstructorUsedError;
  bool get isBasket => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PageItemCopyWith<PageItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PageItemCopyWith<$Res> {
  factory $PageItemCopyWith(PageItem value, $Res Function(PageItem) then) =
      _$PageItemCopyWithImpl<$Res>;
  $Res call(
      {int index,
      String title,
      String appBarTitle,
      bool showOnMobile,
      IconData? icon,
      bool isBasket});
}

/// @nodoc
class _$PageItemCopyWithImpl<$Res> implements $PageItemCopyWith<$Res> {
  _$PageItemCopyWithImpl(this._value, this._then);

  final PageItem _value;
  // ignore: unused_field
  final $Res Function(PageItem) _then;

  @override
  $Res call({
    Object? index = freezed,
    Object? title = freezed,
    Object? appBarTitle = freezed,
    Object? showOnMobile = freezed,
    Object? icon = freezed,
    Object? isBasket = freezed,
  }) {
    return _then(_value.copyWith(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      appBarTitle: appBarTitle == freezed
          ? _value.appBarTitle
          : appBarTitle // ignore: cast_nullable_to_non_nullable
              as String,
      showOnMobile: showOnMobile == freezed
          ? _value.showOnMobile
          : showOnMobile // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      isBasket: isBasket == freezed
          ? _value.isBasket
          : isBasket // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_PageItemCopyWith<$Res> implements $PageItemCopyWith<$Res> {
  factory _$$_PageItemCopyWith(
          _$_PageItem value, $Res Function(_$_PageItem) then) =
      __$$_PageItemCopyWithImpl<$Res>;
  @override
  $Res call(
      {int index,
      String title,
      String appBarTitle,
      bool showOnMobile,
      IconData? icon,
      bool isBasket});
}

/// @nodoc
class __$$_PageItemCopyWithImpl<$Res> extends _$PageItemCopyWithImpl<$Res>
    implements _$$_PageItemCopyWith<$Res> {
  __$$_PageItemCopyWithImpl(
      _$_PageItem _value, $Res Function(_$_PageItem) _then)
      : super(_value, (v) => _then(v as _$_PageItem));

  @override
  _$_PageItem get _value => super._value as _$_PageItem;

  @override
  $Res call({
    Object? index = freezed,
    Object? title = freezed,
    Object? appBarTitle = freezed,
    Object? showOnMobile = freezed,
    Object? icon = freezed,
    Object? isBasket = freezed,
  }) {
    return _then(_$_PageItem(
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      appBarTitle: appBarTitle == freezed
          ? _value.appBarTitle
          : appBarTitle // ignore: cast_nullable_to_non_nullable
              as String,
      showOnMobile: showOnMobile == freezed
          ? _value.showOnMobile
          : showOnMobile // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as IconData?,
      isBasket: isBasket == freezed
          ? _value.isBasket
          : isBasket // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PageItem implements _PageItem {
  const _$_PageItem(
      {required this.index,
      required this.title,
      required this.appBarTitle,
      this.showOnMobile = true,
      this.icon,
      this.isBasket = false});

  @override
  final int index;
  @override
  final String title;
  @override
  final String appBarTitle;
  @override
  @JsonKey()
  final bool showOnMobile;
  @override
  final IconData? icon;
  @override
  @JsonKey()
  final bool isBasket;

  @override
  String toString() {
    return 'PageItem(index: $index, title: $title, appBarTitle: $appBarTitle, showOnMobile: $showOnMobile, icon: $icon, isBasket: $isBasket)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PageItem &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.appBarTitle, appBarTitle) &&
            const DeepCollectionEquality()
                .equals(other.showOnMobile, showOnMobile) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality().equals(other.isBasket, isBasket));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(appBarTitle),
      const DeepCollectionEquality().hash(showOnMobile),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(isBasket));

  @JsonKey(ignore: true)
  @override
  _$$_PageItemCopyWith<_$_PageItem> get copyWith =>
      __$$_PageItemCopyWithImpl<_$_PageItem>(this, _$identity);
}

abstract class _PageItem implements PageItem {
  const factory _PageItem(
      {required final int index,
      required final String title,
      required final String appBarTitle,
      final bool showOnMobile,
      final IconData? icon,
      final bool isBasket}) = _$_PageItem;

  @override
  int get index;
  @override
  String get title;
  @override
  String get appBarTitle;
  @override
  bool get showOnMobile;
  @override
  IconData? get icon;
  @override
  bool get isBasket;
  @override
  @JsonKey(ignore: true)
  _$$_PageItemCopyWith<_$_PageItem> get copyWith =>
      throw _privateConstructorUsedError;
}
