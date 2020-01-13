import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocket_manager2/ResponseProvider.dart';

import 'Connection.dart';
import 'WsView.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ResponseProvider()),
      ChangeNotifierProvider(create: (_) => ResponseProvider()),
      ChangeNotifierProvider(create: (_) => ResponseProvider()),
    ],
    child: MyApp(),
  ));
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
