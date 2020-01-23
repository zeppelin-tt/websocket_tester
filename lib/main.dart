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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Connection connection;

  didChangeDependencies() {
    super.didChangeDependencies();
    if (connection == null) connection = Connection(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WsView(),
    );
  }
}
