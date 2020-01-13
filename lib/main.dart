import 'package:flutter/material.dart';

import 'WsView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WsView(),
    );
  }
}
