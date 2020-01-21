import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:websocket_manager/websocket_manager.dart';
import 'package:websocket_manager2/AddressProvider.dart';
import 'package:websocket_manager2/HistoryItem.dart';
import 'package:websocket_manager2/HistoryProvider.dart';
import 'package:websocket_manager2/RequestProvider.dart';

class Connection {
  int messageNum = 0;
  RequestProvider requestProvider;
  AddressProvider addressProvider;
  HistoryProvider historyProvider;
  WebsocketManager _socket;

  Connection({BuildContext context}) {
    requestProvider = Provider.of<RequestProvider>(context);
    addressProvider = Provider.of<AddressProvider>(context);
    historyProvider = Provider.of<HistoryProvider>(context);
    addressProvider.addListener(_connect);
  }

  _connect() {
    if (_socket != null) _disconnect();
    _socket = WebsocketManager(addressProvider.address);
    _socket.onClose((dynamic message) {
      print('close');
    });
    _socket.onMessage((dynamic message) {
      print('recv: $message');
      historyProvider.addMessage(HistoryItem(MessageFocus.income, message));
    });
    requestProvider.addListener(_send);
    _socket.connect();
  }

  _send() {
    _socket.send(requestProvider.request);
  }

  _disconnect() {
    _socket.close();
    requestProvider.removeListener(_send);
  }
}
