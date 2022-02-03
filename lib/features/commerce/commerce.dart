import 'package:flutter/foundation.dart';

@immutable
class Commerce {
  const Commerce({
    required this.description,
    required this.schedules,
    required this.address,
    required this.phoneNumber,
    required this.emailAddress
  });

  final String description;
  final Map<String, String> schedules; // TODO: since this is not the final data structure it's String for now

  final String address;
  final String phoneNumber;
  final String emailAddress;

  Commerce copyWith({
    String? description,
    Map<String, String>? schedules,
    String? address,
    String? phoneNumber,
    String? emailAddress,
  }) {
    return Commerce(
      description: description ?? this.description,
      schedules: schedules ?? this.schedules,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }

  @override 
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Commerce &&
      other.description == description &&
      other.schedules == schedules &&
      other.address == address &&
      other.phoneNumber == phoneNumber &&
      other.emailAddress == emailAddress;
  }

  @override
  int get hashCode => description.hashCode ^
                      schedules.hashCode ^
                      address.hashCode ^
                      phoneNumber.hashCode ^
                      emailAddress.hashCode;
}