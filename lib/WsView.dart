import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:websocket_manager2/AddressProvider.dart';
import 'package:websocket_manager2/HistoryItem.dart';
import 'package:websocket_manager2/HistoryProvider.dart';
import 'package:websocket_manager2/RequestProvider.dart';

class WsView extends StatefulWidget {
  @override
  _WsViewState createState() => _WsViewState();
}

class _WsViewState extends State<WsView> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _messageToSendController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final requestProvider = Provider.of<RequestProvider>(context);
    final addressProvider = Provider.of<AddressProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context);
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        final _maxHeight = constraints.biggest.height;
        final _maxWidth = constraints.biggest.width;
        final _horizontalPadding = _maxWidth * .035;
        final _inputHeight = _maxHeight * .06;
        final _borderRadius = _maxWidth * .015;
        final _distanceBetween = _maxWidth * .035;
        final _infoHeaderHeight = _inputHeight * 2 + _distanceBetween * 3;
        return Material(
          color: Colors.black,
          child: Stack(
            children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: _infoHeaderHeight),
                    Container(
                      height: _maxHeight - _infoHeaderHeight - _inputHeight - _distanceBetween * 2 - MediaQuery.of(context).viewInsets.bottom ,
                      margin: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(_borderRadius)),
                    )
                  ],
                ),
              Column(
                children: <Widget>[
                  SizedBox(height: _distanceBetween),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                    child: SizedBox(
                      height: _inputHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: double.infinity,
                            width: _maxWidth * .6,
                            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(_borderRadius)),
                            child: TextField(
                              maxLines: 1,
                              style: TextStyle(color: Colors.white70),
                              controller: _addressController,
                              decoration: InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                hintText: 'address',
                                hintStyle: TextStyle(color: Colors.white60),
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            child: SizedBox(
                              height: double.infinity,
                              width: _maxWidth - _horizontalPadding * 2 - _maxWidth * .6 - _distanceBetween,
                              child: FlatButton(
                                color: Color(0xff2ca5e0),
                                onPressed: () => addressProvider.setAddress(_addressController.text),
                                child: Text('Connect', style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 17.0)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: _distanceBetween),
                  Container(
                    constraints: BoxConstraints(maxHeight: _maxHeight * .32, minHeight: _inputHeight),
                    margin: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(_borderRadius)),
                    child: TextField(
                      minLines: 1,
                      maxLines: 10,
                      style: TextStyle(color: Colors.white70, fontSize: 16.0),
                      controller: _messageToSendController,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'message',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                  SizedBox(height: _distanceBetween),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: _maxHeight * .014, horizontal: _maxWidth * .027),
                          child: Text(
                            historyProvider.items.isEmpty ? 'here will be response...' : historyProvider.asString,
                            style: TextStyle(color: historyProvider.items.isEmpty ? Colors.white70 : Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: _distanceBetween),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    child: SizedBox(
                      height: _inputHeight,
                      width: _maxWidth - _horizontalPadding * 2,
                      child: FlatButton(
                        color: Color(0xff2ca5e0),
                        child: Text('Send message', style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 17.0)),
                        onPressed: () {
                          requestProvider.setRequest(_messageToSendController.text);
                          historyProvider.addMessage(HistoryItem(MessageFocus.output, _messageToSendController.text));
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: _distanceBetween + MediaQuery.of(context).viewInsets.bottom)
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _addressController.dispose();
    _messageToSendController.dispose();
  }
}


Size getStringSize(String text, double fontSize, [double maxWidth]) {
  RenderParagraph renderParagraph = RenderParagraph(
    TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
      ),
    ),
    textDirection: TextDirection.ltr,
    maxLines: 1,
  );
  if (maxWidth != null) {
    final constraints = BoxConstraints(
      maxWidth: maxWidth,
      minHeight: 0.0,
      minWidth: 0.0,
    );
    renderParagraph.layout(constraints);
  }
  return Size(renderParagraph.getMinIntrinsicWidth(fontSize).ceilToDouble(), renderParagraph.getMinIntrinsicHeight(fontSize).ceilToDouble()) ;
}

int getStringLines(String text, double fontSize, int maxLines, double maxWidth) {
  final textSpan = TextSpan(text: text, style: TextStyle(fontSize: fontSize));
  final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr, maxLines: maxLines);
  textPainter.layout(maxWidth: maxWidth);
  return textPainter.computeLineMetrics().length;
}

