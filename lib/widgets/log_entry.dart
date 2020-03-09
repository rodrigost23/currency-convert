import 'package:currency_convert/models/conversion_log_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogEntryWidget extends StatelessWidget {
  final ConversionLogEntry logEntry;

  const LogEntryWidget(this.logEntry, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${logEntry.input} → ${logEntry.result}"),
      subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(logEntry.timestamp.toLocal())),
    );
  }
}
