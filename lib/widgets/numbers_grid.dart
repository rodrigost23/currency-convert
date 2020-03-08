import 'package:flutter/material.dart';

import '../widgets/keyboard_button.dart';

/// A calculator-like grid of numbers
class NumbersGrid extends StatelessWidget {
  const NumbersGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rowItems = <Widget>[];
    for (var i = 7; i <= 9; i++) {
      var columnItems = <Widget>[];
      for (var j = 0; j < 12; j = j + 3) {
        String value = j < 8 ? (i - j).toString() : (i - j == -2 ? ',' : (i - j == 0 ? '=' : '0'));

        columnItems.add(
          Expanded(child: KeyboardButton(text: value)),
        );
      }

      rowItems.add(
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: columnItems,
          ),
        ),
      );
    }

    return Row(
      children: rowItems,
    );
  }
}
