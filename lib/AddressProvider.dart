import 'package:flutter/cupertino.dart';

class AddressProvider with ChangeNotifier {
  String _address;

  AddressProvider() : this._address = '';

  String get address => _address;

  setRequest(String address) {
    this._address = address;
    notifyListeners();
  }
}