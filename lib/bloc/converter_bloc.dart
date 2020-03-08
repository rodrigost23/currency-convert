import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'converter_event.dart';
part 'converter_state.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  final ConverterEditing _initialState;

  ConverterBloc(ConverterEditing initialState) : this._initialState = initialState;

  @override
  Stream<ConverterState> skip(int count) => super.skip(count ?? 0);

  @override
  ConverterState get initialState => this._initialState;

  @override
  Stream<ConverterState> mapEventToState(
    ConverterEvent event,
  ) async* {
    var currentState = this.state;

    // Any editing event
    if (event is ConverterEdit) {
      var value = currentState.value;

      // Typing a number
      if (event is ConverterAddNumber) {
        value = Decimal.parse(value.toStringAsFixed(2) + event.number);
        value *= Decimal.fromInt(10);

        // Pressing backspace
      } else if (event is ConverterDeleteNumber) {
        var valueStr = value.toStringAsFixed(2);
        valueStr = valueStr.substring(0, valueStr.length - 1);

        value = Decimal.parse(valueStr);
        value /= Decimal.fromInt(10);

        // Long-pressing backspace
      } else if (event is ConverterClear) {
        value = Decimal.zero;
      }

      yield ConverterEditing.fromState(currentState, value: value);

      // Pressing equals
    } else if (event is ConverterCalculate) {
      yield ConverterResulted.fromState(currentState, result: Decimal.fromInt(2));
    }
    return;
  }
}
