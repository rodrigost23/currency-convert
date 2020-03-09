part of 'converter_bloc.dart';

abstract class ConverterEvent extends Equatable {
  const ConverterEvent();

  @override
  List<Object> get props => [];

  static const commandDelete = "del";
  static const commandClear = "clr";
  static const commandCalculate = "=";

  /// Gets the corresponding event to the [command] provided
  static ConverterEvent getEventFromCommand(String command) {
    switch (command) {
      case ConverterEvent.commandDelete:
        return ConverterDeleteNumber();
      case ConverterEvent.commandClear:
        return ConverterClear();
      case ConverterEvent.commandCalculate:
        return ConverterCalculate();
      case "0":
      case "1":
      case "2":
      case "3":
      case "4":
      case "5":
      case "6":
      case "7":
      case "8":
      case "9":
        return ConverterAddNumber(command);
      default:
        throw ArgumentError.value(command, "command");
    }
  }
}

abstract class ConverterEdit extends ConverterEvent {
  const ConverterEdit();
}

/// Adds a number to the edit field
class ConverterAddNumber extends ConverterEdit {
  final String number;

  const ConverterAddNumber(this.number);

  @override
  List<Object> get props => [this.number];
}

/// Deletes the last number of the edit field
class ConverterDeleteNumber extends ConverterEdit {
  const ConverterDeleteNumber();
}

/// Clears the whole conversion
class ConverterClear extends ConverterEdit {
  const ConverterClear();
}

/// Calculates the conversion
class ConverterCalculate extends ConverterEvent {
  const ConverterCalculate();
}

/// Change the currency from which to convert
class ConverterChangeFromCurrency extends ConverterEvent {
  final Currency currency;

  const ConverterChangeFromCurrency(this.currency);
}

/// Change the currency to which to convert
class ConverterChangeToCurrency extends ConverterEvent {
  final Currency currency;

  const ConverterChangeToCurrency(this.currency);
}

/// Swap input and output currencies with each other
class ConverterSwapCurrencies extends ConverterEvent {}
