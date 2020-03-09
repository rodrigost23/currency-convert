part of 'converter_bloc.dart';

abstract class ConverterState extends Equatable {
  /// The code corresponding to the currency to convert from (e.g "USD")
  final Currency fromCurrency;

  /// The code corresponding to the currency to convert to (e.g "BRL")
  final Currency toCurrency;

  /// The value to convert from. Defaults to zero.
  final Money value;

  ConverterState({@required this.fromCurrency, @required this.toCurrency, Money value})
      : this.value = value ?? Money.from(0, fromCurrency);

  ConverterState.fromState(ConverterState state, {value})
      : this(
          fromCurrency: state.fromCurrency,
          toCurrency: state.toCurrency,
          value: value ?? state.value,
        );

  @override
  List<Object> get props => [fromCurrency, toCurrency, value];
}

/// State for then the number to convert is being edited
class ConverterEditing extends ConverterState {
  ConverterEditing({@required fromCurrency, @required toCurrency, Money value})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          value: value,
        );

  ConverterEditing.fromState(ConverterState state, {Money value}) : super.fromState(state, value: value);

  ConverterEditing copyWith({
    Currency fromCurrency,
    Currency toCurrency,
    Money value,
  }) =>
      ConverterEditing(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
        value: value ?? this.value,
      );
}

/// State for when the conversion is loading from the server
class ConverterLoading extends ConverterState {
  ConverterLoading({@required fromCurrency, @required toCurrency, Money value})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          value: value,
        );

  ConverterLoading.fromState(ConverterState state, {Money value}) : super.fromState(state, value: value);

  ConverterLoading copyWith({fromCurrency, toCurrency, value}) => ConverterLoading(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
        value: value ?? this.value,
      );
}

/// State for when the result is shown from the conversion
class ConverterResulted extends ConverterState {
  final Money result;
  ConverterResulted({@required fromCurrency, @required toCurrency, Money value, @required this.result})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
          value: value,
        );

  @override
  List<Object> get props => super.props + [result];

  ConverterResulted.fromState(ConverterState state, {Money value, @required this.result})
      : super.fromState(state, value: value);

  ConverterResulted copyWith({fromCurrency, toCurrency, value, result}) => ConverterResulted(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
        value: value ?? this.value,
        result: result ?? this.result,
      );
}

/// If there's an error
class ConverterError extends ConverterState {
  final String error;
  final String details;

  ConverterError.fromState(
    ConverterState state, {
    @required this.error,
    this.details,
    Money value,
  }) : super.fromState(state, value: value);
}
