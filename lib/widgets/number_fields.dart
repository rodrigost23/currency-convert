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
    var result = Money.fromInt(0, BlocProvider.of<ConverterBloc>(context).state.toCurrency).toString();

    return BlocBuilder<ConverterBloc, ConverterState>(builder: (context, state) {
      if (state is ConverterResulted) {
        result = state.result.toString();
      } else if (state is ConverterError) {
        result = state.error;
      }

      return Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: NumberField(
                text: state.value.toString(),
                currency: state.fromCurrency,
                onCurrencySelected: (currency) =>
                    BlocProvider.of<ConverterBloc>(context).add(ConverterChangeFromCurrency(currency)),
                color: state is ConverterResulted ? inactiveColor : null,
                onTap: state is ConverterResulted
                    ? () => BlocProvider.of<ConverterBloc>(context).add(ConverterFocus())
                    : null,
              ),
            ),
            Divider(
              indent: 16,
              endIndent: 16,
              thickness: 2,
            ),
            Expanded(
              child: NumberField(
                text: result,
                currency: state.toCurrency,
                onCurrencySelected: (currency) =>
                    BlocProvider.of<ConverterBloc>(context).add(ConverterChangeToCurrency(currency)),
                loading: state is ConverterLoading,
                hidden: state is! ConverterResulted && state is! ConverterError,
                color: state is ConverterError ? Theme.of(context).errorColor : null,
              ),
            ),
          ],
        ),
      );
    });
  }
}
