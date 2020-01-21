import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:websocket_manager2/HistoryItem.dart';

class HistoryProvider with ChangeNotifier {
  List<HistoryItem> _items;

  HistoryProvider() : this._items = [];

  List<HistoryItem> get items => _items;

  addMessage(HistoryItem item) {
    _items.add(item);
    notifyListeners();
  }

  String get asString => _items.fold('', (a, b) =>'${a.toString()}\n${b.toString()}');
}
