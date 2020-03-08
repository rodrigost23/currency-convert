import 'package:flutter/material.dart';

class NumberFields extends StatefulWidget {
  NumberFields({Key key}) : super(key: key);

  @override
  _NumberFieldsState createState() => _NumberFieldsState();
}

class _NumberFieldsState extends State<NumberFields> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Text(
              "R\$ 1,00",
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.display2,
            ),
          ),
          Divider(
            indent: 16,
            endIndent: 16,
            thickness: 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Text(
              "\$ 4,69",
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .display2
                  .copyWith(color: Theme.of(context).textTheme.body1.color),
            ),
          ),
        ],
      ),
    );
  }
}
