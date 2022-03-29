import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'commerce.freezed.dart';
part 'commerce.g.dart';

mixin CommerceServices {
  static const String clickAndCollect = "CLICKANDCOLLECT";
}

@freezed
@immutable
class Commerce with _$Commerce {
  const factory Commerce(String? id, {
    required String name,
    @Default(<String>[]) List<String> categories,
    @Default(<String>[]) List<String> services,
    String? storekeeperWord,
    String? description,
    String? address,
    String? phone,
    String? email,
    String? facebook,
    String? twitter,
    String? instagram,
  }) = _Commerce;

  factory Commerce.fromJson(Map<String, dynamic> json) => _$CommerceFromJson(json);
}