import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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

      // Clear input if already showed result
      if (currentState is ConverterResulted) {
        value = Money.fromInt(0, currentState.fromCurrency);
      }

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
      return;
    }

    // Change currency
    if (event is ConverterChangeCurrency) {
      /// Is the input currency being changed? If false, the output is.
      var changeFromCurrency = event is ConverterChangeFromCurrency;

      // If the currency being changed is the same as the other one
      if (event.currency == (changeFromCurrency ? currentState.toCurrency : currentState.fromCurrency)) {
        yield _swapCurrencies(currentState);
      } else {
        yield _changeCurrencies(
          currentState,
          input: changeFromCurrency ? event.currency : null,
          output: changeFromCurrency ? null : event.currency,
        );
      }
      return;
    }

    // Pressing equals
    if (event is ConverterCalculate) {
      try {
        yield ConverterLoading.fromState(currentState);

        var result = await repository.getConversion(currentState.value, currentState.toCurrency);
        yield ConverterResulted.fromState(currentState, result: result);
      } catch (e) {
        yield _exceptionToState(currentState, error: e);
      }
    }
  }

  /// Swap input and output currencies with each other
  ConverterState _swapCurrencies<T extends ConverterState>(T state) {
    if (state is ConverterResulted) {
      return ConverterResulted(
        fromCurrency: state.toCurrency,
        toCurrency: state.fromCurrency,
        value: state.result,
        result: state.value,
      );
    }
    return ConverterEditing(
        fromCurrency: state.toCurrency,
        toCurrency: state.fromCurrency,
        value: state.value.exchangeTo(Money.from(1, state.toCurrency)));
  }

  /// Change currencies, while converting the display format
  ConverterEditing _changeCurrencies(ConverterState state, {Currency input, Currency output}) {
    return ConverterEditing.fromState(state).copyWith(
      fromCurrency: input,
      toCurrency: output,
      value: state.value.exchangeTo(Money.from(1, state.fromCurrency)),
    );
  }

  ConverterError _exceptionToState(ConverterState state, {error}) {
    var errorMessage = "ERRO";
    String details;
    if (error is DioError) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        details = "Servidor fora de alcance";
      } else if (error.error is SocketException && error.error.osError.errorCode == 101) {
        details = "Verifique sua conexão";
      }
    } else {
      debugPrint(error.toString());
    }
    return ConverterError.fromState(state, error: errorMessage, details: details);
  }
}
