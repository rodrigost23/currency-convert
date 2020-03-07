import 'package:flutter/material.dart';

/// The buttons in the calculator-like keyboard
class KeyboardButton extends StatelessWidget {
  final String text;
  final String value;
  final Widget child;

  /// Creates a keyboard button.
  ///
  /// Only one of the [text] or [child] arguments must be defined.
  ///
  /// If the [value] argument is null, the value defaults to the defined in [text].
  /// Instead, if [child] is provided, then [value] may not be null.
  KeyboardButton({this.text, this.child, this.value, Key key})
      : assert(text != null || child != null),
        assert(child == null || value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) => FlatButton(
      onPressed: () {
        // TODO: Send this.value if it's not null, otherwise send this.text
      },
      shape: CircleBorder(),
      padding: EdgeInsets.all(24),
      child: this.text != null
          ? Text(
              this.text,
              style: Theme.of(context).textTheme.display1,
            )
          : this.child,
    );
}
