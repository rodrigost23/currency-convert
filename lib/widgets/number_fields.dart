import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/converter_bloc.dart';

class NumberFields extends StatefulWidget {
  NumberFields({Key key}) : super(key: key);

  @override
  _NumberFieldsState createState() => _NumberFieldsState();
}

class _NumberFieldsState extends State<NumberFields> {
  @override
  Widget build(BuildContext context) {
    var inactiveText = Theme.of(context).textTheme.display2;
    var activeText = inactiveText.copyWith(color: Theme.of(context).textTheme.body1.color);
    var result = Decimal.zero;

    return BlocBuilder<ConverterBloc, ConverterState>(builder: (context, snapshot) {
      if (snapshot is ConverterResulted) {
        result = snapshot.result;
      }

      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              height: 100,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                snapshot.value.toStringAsFixed(2),
                textAlign: TextAlign.end,
                style: ConverterState is ConverterEditing ? inactiveText : activeText,
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              thickness: 2,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              height: 100,
              alignment: AlignmentDirectional.centerEnd,
              child: AnimatedOpacity(
                opacity: snapshot is ConverterResulted ? 1 : 0,
                duration: Duration(milliseconds: 100),
                child: Text(
                  result.toStringAsFixed(2),
                  textAlign: TextAlign.end,
                  style: activeText,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
