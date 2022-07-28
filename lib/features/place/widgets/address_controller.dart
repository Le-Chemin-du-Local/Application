import 'package:chemin_du_local/features/place/models/address/address.dart';
import 'package:flutter/material.dart';

class AddressController with ChangeNotifier {
  Address _address = const Address();

  Address get address => _address;
  set address(Address newAddress) {
    _address = newAddress;
    notifyListeners();
  }
}