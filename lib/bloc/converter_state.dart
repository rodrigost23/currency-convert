part of 'converter_bloc.dart';

abstract class ConverterState extends Equatable {
  /// The code corresponding to the currency to convert from (e.g "USD")
  final String fromCurrency;

  /// The code corresponding to the currency to convert to (e.g "BRL")
  final String toCurrency;

  /// The value to convert from. Defaults to zero.
  final Decimal value;

  ConverterState({@required this.fromCurrency, @required this.toCurrency, Decimal value})
      : this.value = value ?? Decimal.fromInt(0);

  ConverterState.fromState(ConverterState state, {value})
      : this(
          fromCurrency: state.fromCurrency,
          toCurrency: state.toCurrency,
          value: value ?? state.value,
        );

  @override
  List<Object> get props => [fromCurrency, toCurrency];
}

/// State for then the number to convert is being edited
class ConverterEditing extends ConverterState {
  ConverterEditing({@required fromCurrency, @required toCurrency, Decimal value})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          value: value,
        );

  ConverterEditing.fromState(ConverterState state, {Decimal value}) : super.fromState(state, value: value);

  ConverterEditing copyWith({fromCurrency, toCurrency, value}) => ConverterEditing(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
        value: value ?? this.value,
      );
}

/// State for when the conversion is loading from the server
class ConverterLoading extends ConverterState {
  ConverterLoading({@required fromCurrency, @required toCurrency, Decimal value})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          value: value,
        );

  ConverterLoading.fromState(ConverterState state, {Decimal value}) : super.fromState(state, value: value);

  ConverterLoading copyWith({fromCurrency, toCurrency, value}) => ConverterLoading(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
        value: value ?? this.value,
      );
}

/// State for when the result is shown from the conversion
class ConverterResulted extends ConverterState {
  final Decimal result;
  ConverterResulted({@required fromCurrency, @required toCurrency, Decimal value, @required this.result})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          value: value,
        );

  ConverterResulted.fromState(ConverterState state, {Decimal value, @required this.result}) : super.fromState(state, value: value);

  ConverterResulted copyWith({fromCurrency, toCurrency, value, result}) => ConverterResulted(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
        value: value ?? this.value,
        result: result ?? this.result,
      );
}
