import 'package:flutter/material.dart';

class CurrencyPicker extends StatefulWidget {
  CurrencyPicker({Key key}) : super(key: key);

  @override
  _CurrencyPickerState createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: [
        DropdownMenuItem(
          child: Text("BRL"),
        )
      ],
      onChanged: (_) {},
    );
  }
}
