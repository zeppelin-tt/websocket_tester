import 'package:flutter/cupertino.dart';

class ResponseProvider with ChangeNotifier {
  String _response;

  String get response => _response;

  setResponse(String response) {
    this._response = response;
    notifyListeners();
  }
}