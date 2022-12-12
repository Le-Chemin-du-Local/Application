import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@immutable
@freezed
class Address with _$Address {
  const Address._();

  const factory Address({
    String? number,
    String? route,
    String? optionalRoute,
    String? postalCode,
    String? city
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  String get detailled => "$number $route, $postalCode $city";
}