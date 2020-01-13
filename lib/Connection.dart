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

  Connection({BuildContext context}) {
    requestProvider = Provider.of<RequestProvider>(context);
    responseProvider = Provider.of<ResponseProvider>(context);
    addressProvider = Provider.of<AddressProvider>(context);
    _init();
  }

  _init() {
    final socket = WebsocketManager(addressProvider.address);
    socket.onClose((dynamic message) {
      print('close');
    });
    socket.onMessage((dynamic message) {
      print('recv: $message');
      responseProvider.setResponse(message);
      if (messageNum == 10) {
        socket.close();
      } else {
        messageNum += 1;
        final String msg = '$messageNum: ${DateTime.now()}';
        print('send: $msg');
        socket.send(msg);
      }
    });
    socket.connect();
  }
}


