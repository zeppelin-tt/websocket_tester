class HistoryItem {
  MessageFocus messageFocus;
  String message;
  DateTime time;

  HistoryItem(this.messageFocus, this.message) : this.time = DateTime.now();

  @override
  String toString() => '${time.hour}:${time.minute}:${time.second} ${messageFocus == MessageFocus.income ? '<-' : '->'} $message';
}

enum MessageFocus { income, output }