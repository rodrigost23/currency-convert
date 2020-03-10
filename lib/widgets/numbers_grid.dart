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
        String value = (i - j).toString();

        // Number zero:
        if (value == '-1') {
          value = "0";
          // Equal button:
        } else if (value == '0') {
          value = "=";
          // If not a number:
        } else if (j > 6) {
          value = null;
        }

        // Space below "1":
        if (value == null) {
          columnItems.add(
            Expanded(child: Container()),
          );
          // Other keys:
        } else {
          columnItems.add(
            Expanded(child: KeyboardButton(text: value)),
          );
        }
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
