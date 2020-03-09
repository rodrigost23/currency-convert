import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:skeleton_text/skeleton_text.dart';

import 'currency_picker.dart';

class NumberField extends StatelessWidget {
  final String text;
  final Color color;
  final bool loading;
  final bool hidden;
  final Currency currency;
  final Function(Currency) onCurrencySelected;

  const NumberField({
    Key key,
    @required this.text,
    @required this.currency,
    @required this.onCurrencySelected,
    this.color,
    this.loading = false,
    this.hidden = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context)
        .textTheme
        .display2
        .copyWith(color: color ?? Theme.of(context).textTheme.body1.color);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          CurrencyPicker(
            selectedItem: currency,
            onChanged: onCurrencySelected,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsetsDirectional.only(start: 8),
              height: 100,
              alignment: AlignmentDirectional.centerEnd,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: loading
                    ? SkeletonAnimation(
                        child: Container(
                          child: Text(
                            text,
                            textAlign: TextAlign.end,
                            style: textStyle.copyWith(color: Colors.transparent),
                          ),
                          decoration:
                              BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                        ),
                      )
                    : AnimatedOpacity(
                        opacity: hidden ? 0 : 1,
                        duration: Duration(milliseconds: 100),
                        child: AutoSizeText(
                          text,
                          textAlign: TextAlign.end,
                          softWrap: true,
                          style: color != null ? textStyle.copyWith(color: color) : textStyle,
                          maxLines: 1,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
