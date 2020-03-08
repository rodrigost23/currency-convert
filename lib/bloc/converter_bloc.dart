import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:money2/money2.dart';

import '../repository/converter_repository.dart';

part 'converter_event.dart';
part 'converter_state.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  final ConverterEditing _initialState;
  final ConverterRepository repository;

  ConverterBloc(ConverterEditing initialState, {@required this.repository})
      : this._initialState = initialState;

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
        // Prevents from typing a number too big
        if (value.minorUnits.toString().length <= 8) {
          value *= 10;
          value = value + Money.fromInt(int.tryParse(event.number), currentState.fromCurrency);
        }

        // Pressing backspace
      } else if (event is ConverterDeleteNumber) {
        var minorDigits = value.minorUnits ~/ BigInt.from(10);
        value = Money.fromBigInt(minorDigits, currentState.fromCurrency);

        // Long-pressing backspace
      } else if (event is ConverterClear) {
        value = Money.fromInt(0, currentState.fromCurrency);
      }

      yield ConverterEditing.fromState(currentState, value: value);

      // Pressing equals
    } else if (event is ConverterCalculate) {
      yield ConverterLoading.fromState(currentState);

      var result = await repository.getConversion(currentState.value, currentState.toCurrency);
      yield ConverterResulted.fromState(currentState, result: result);
    }
    return;
  }
}
