import 'package:currency_convert/models/conversion_log_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogEntryWidget extends StatelessWidget {
  final ConversionLogEntry logEntry;

  const LogEntryWidget(this.logEntry, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              "${logEntry.input}",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Icon(Icons.arrow_right),
          Expanded(
            child: Text(
              "${logEntry.result}",
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
        ],
      ),
      subtitle: Text(
        DateFormat('dd/MM/yyyy HH:mm').format(logEntry.timestamp.toLocal()),
        textAlign: TextAlign.center,
      ),
    );
  }
}
