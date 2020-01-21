import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocket_manager2/AddressProvider.dart';
import 'package:websocket_manager2/HistoryProvider.dart';
import 'package:websocket_manager2/RequestProvider.dart';

import 'Connection.dart';
import 'WsView.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RequestProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Connection(context: context);
    return MaterialApp(
      home: WsView(),
    );
  }
}
