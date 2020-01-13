import 'package:flutter/cupertino.dart';

class RequestProvider with ChangeNotifier {
  String _request;

  String get request => _request;

  setRequest(String request) {
    this._request = request;
    notifyListeners();
  }
}