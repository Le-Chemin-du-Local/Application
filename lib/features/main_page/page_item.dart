import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_item.freezed.dart';

@freezed
@immutable
class PageItem with _$PageItem {
  const factory PageItem({
    required int index,
    required String title,
    required String appBarTitle,
    @Default(true) bool showOnMobile,
    IconData? icon,
    @Default(false) bool isBasket,
  }) = _PageItem;
}