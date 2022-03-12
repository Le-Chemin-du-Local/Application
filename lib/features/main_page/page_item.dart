import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_item.freezed.dart';

@freezed
@immutable
class PageItem with _$PageItem {
  const factory PageItem({
    required int index,
    required String title,
    required String appBarTitle,
    IconData? icon,
    Widget? suffixWidget,

  }) = _PageItem;
}