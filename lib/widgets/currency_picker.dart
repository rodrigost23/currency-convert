import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

class CurrencyPicker extends StatefulWidget {
  CurrencyPicker({Key key}) : super(key: key);

  @override
  _CurrencyPickerState createState() => _CurrencyPickerState();
}

class _CurrencyPickerState extends State<CurrencyPicker> {
  // TODO: Get this list from somewhere else
  final currencies = {
    Currencies.find("BRL"): "BR",
    Currencies.find("EUR"): "EU",
    Currencies.find("USD"): "US",
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<Currency>(
        value: currencies.keys.first,
        items: currencies.entries
            .map(
              (entry) => DropdownMenuItem(
                child: Row(
                  children: [
                    Flags.getMiniFlag(entry.value, 20, 10),
                    Container(width: 10),
                    Text(entry.key.code),
                  ],
                ),
                value: entry.key,
              ),
            )
            .toList(),
        onChanged: (_) {},
      ),
    );
  }
}
