import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';

import '../bloc/converter_bloc.dart';
import 'number_field.dart';

class NumberFields extends StatefulWidget {
  NumberFields({Key key}) : super(key: key);

  @override
  _NumberFieldsState createState() => _NumberFieldsState();
}

class _NumberFieldsState extends State<NumberFields> {
  @override
  Widget build(BuildContext context) {
    Color inactiveColor = Theme.of(context).unselectedWidgetColor;
    var result = Money.fromInt(0, BlocProvider.of<ConverterBloc>(context).state.toCurrency);

    return BlocBuilder<ConverterBloc, ConverterState>(builder: (context, snapshot) {
      if (snapshot is ConverterResulted) {
        result = snapshot.result;
      }

      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            NumberField(
              text: snapshot.value.toString(),
              color: snapshot is ConverterResulted ? inactiveColor : null,
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              thickness: 2,
            ),
            NumberField(
              text: result.toString(),
              loading: snapshot is ConverterLoading,
              hidden: snapshot is! ConverterResulted,
            ),
          ],
        ),
      );
    });
  }
}
