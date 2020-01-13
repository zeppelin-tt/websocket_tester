import 'package:flutter/material.dart';

class WsView extends StatefulWidget {
  @override
  _WsViewState createState() => _WsViewState();
}

class _WsViewState extends State<WsView> {
  final TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300.0,
                  height: 50.0,
                  child: TextField(
                    maxLines: 1,
                    style: TextStyle(color: Colors.white70),
                    controller: _inputController,
                    decoration: InputDecoration(
                        fillColor: Colors.white10,
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'address',
                        hintStyle: TextStyle(color: Colors.white70)),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                  width: 100.0,
                  child: FlatButton(
                    color: Colors.blue,
                    child: Text('Connect', style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 16.0)),
                    onPressed: () {},
                  ),
                )
              ],
            ),
            SizedBox(height: 35.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: TextField(
                maxLines: 10,
                style: TextStyle(color: Colors.white70),
                controller: _inputController,
                decoration: InputDecoration(
                    fillColor: Colors.white10,
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'message',
                    hintStyle: TextStyle(color: Colors.white70)),
              ),
            ),
            SizedBox(height: 35.0),
            Text('text', style: TextStyle(color: Colors.white, fontSize: 18.0)),
            Spacer(),
            SizedBox(
              height: 48.0,
              width: 400.0,
              child: FlatButton(
                color: Colors.blue,
                child: Text('Send message', style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 16.0)),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
