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
    if (event is ConverterEdit) {
      var value = currentState.value;
      if (event is ConverterAddNumber) {
        value = Decimal.parse(value.toStringAsFixed(2) + event.number);
        value *= Decimal.fromInt(10);
      }
      yield ConverterEditing.fromState(currentState, value: value);
    } else if (event is ConverterCalculate) {
      yield ConverterResulted.fromState(currentState, result: Decimal.fromInt(2));
    }
    return;
  }
}
