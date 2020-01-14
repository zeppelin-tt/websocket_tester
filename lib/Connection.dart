import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:websocket_manager/websocket_manager.dart';
import 'package:websocket_manager2/AddressProvider.dart';
import 'package:websocket_manager2/RequestProvider.dart';
import 'package:websocket_manager2/ResponseProvider.dart';

class Connection {
  int messageNum = 0;
  RequestProvider requestProvider;
  ResponseProvider responseProvider;
  AddressProvider addressProvider;
  WebsocketManager _socket;

  Connection({BuildContext context}) {
    requestProvider = Provider.of<RequestProvider>(context);
    responseProvider = Provider.of<ResponseProvider>(context);
    addressProvider = Provider.of<AddressProvider>(context);
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
      responseProvider.setResponse(message);
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


