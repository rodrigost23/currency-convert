import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/converter_bloc.dart';

/// The buttons in the calculator-like keyboard
class KeyboardButton extends StatelessWidget {
  /// The text to show if [child] is null.
  final String text;

  /// The content of the button.
  final Widget child;

  /// The value to send to the BLoC when pressing the button.
  /// If this is null, defaults to [text].
  final String value;

  /// The value to send to the BLoC when long-pressing the button.
  final String longPressValue;

  /// Creates a keyboard button.
  ///
  /// Only one of the [text] or [child] arguments must be defined.
  ///
  /// If the [value] argument is null, the value defaults to the defined in [text].
  /// Instead, if [child] is provided, then [value] may not be null.
  KeyboardButton({this.text, this.child, value, this.longPressValue, Key key})
      : assert(text != null || child != null),
        assert(child == null || value != null),
        this.value = value ?? text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    var bloc = BlocProvider.of<ConverterBloc>(context);

    return FlatButton(
      onPressed: () {
        bloc.add(ConverterEvent.getEventFromCommand(this.value));
      },
      onLongPress: this.longPressValue != null
          ? () {
              bloc.add(ConverterEvent.getEventFromCommand(this.longPressValue));
            }
          : null,
      shape: CircleBorder(),
      padding: EdgeInsets.all(24),
      child: this.child == null
          ? Text(
              this.text,
              style: Theme.of(context).textTheme.display1,
            )
          : this.child,
    );
  }
}
