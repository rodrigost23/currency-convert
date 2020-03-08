part of 'converter_bloc.dart';

abstract class ConverterState extends Equatable {
  final String fromCurrency;
  final String toCurrency;

  const ConverterState({@required this.fromCurrency, @required this.toCurrency});

  ConverterState.fromState(ConverterState state)
      : this(fromCurrency: state.fromCurrency, toCurrency: state.toCurrency);

  @override
  List<Object> get props => [fromCurrency, toCurrency];
}

class ConverterEditing extends ConverterState {
  const ConverterEditing({@required fromCurrency, @required toCurrency})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
        );

  ConverterEditing.fromState(ConverterState state) : super.fromState(state);

  ConverterEditing copyWith({fromCurrency, toCurrency}) => ConverterEditing(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
      );
}

class ConverterResulted extends ConverterState {
  const ConverterResulted({@required fromCurrency, @required toCurrency})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
        );

  ConverterResulted.fromState(ConverterState state) : super.fromState(state);

  ConverterResulted copyWith({fromCurrency, toCurrency}) => ConverterResulted(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
      );
}

class ConverterLoading extends ConverterState {
  const ConverterLoading({@required fromCurrency, @required toCurrency})
      : super(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
        );

  ConverterLoading.fromState(ConverterState state) : super.fromState(state);

  ConverterLoading copyWith({fromCurrency, toCurrency}) => ConverterLoading(
        fromCurrency: fromCurrency ?? this.fromCurrency,
        toCurrency: toCurrency ?? this.toCurrency,
      );
}
