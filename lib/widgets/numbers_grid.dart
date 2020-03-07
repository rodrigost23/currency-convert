import 'package:flutter/material.dart';

/// A calculator-like grid of numbers
class NumbersGrid extends StatelessWidget {
  const NumbersGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rowItems = <Widget>[];
    for (var i = 7; i <= 9; i++) {
      var columnItems = <Widget>[];
      for (var j = 0; j < 12; j = j + 3) {
        var value = j < 8 ? (i - j) : (i - j == -2 ? ',' : (i - j == 0 ? '=' : '0'));

        columnItems.add(
          Expanded(
            child: FlatButton(
              onPressed: () {},
              child: Text(
                value.toString(),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
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
