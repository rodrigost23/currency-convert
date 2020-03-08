import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:money2/money2.dart';

class ConversionLogEntry extends Equatable {
  /// Date and time when the conversion was calculated
  final DateTime timestamp;

  /// Currency from which the value was converted
  final Currency fromCurrency;

  /// Input for the conversion
  final Money input;

  /// Result of the conversion
  final Money result;

  const ConversionLogEntry({
    @required this.timestamp,
    @required this.fromCurrency,
    @required this.input,
    @required this.result,
  });

  /// Currency to which the value was converted
  Currency get toCurrency => result.currency;

  @override
  List<Object> get props => [timestamp, fromCurrency, toCurrency, result];

  /// Returns a new instance from the Json data provided
  static ConversionLogEntry fromJson(Map<String, dynamic> data) {
    var fromCurrency = Currencies.find(data['fromCurrency']['code']) ??
        Currency.create(
          data['fromCurrency']['code'],
          2,
          symbol: data['fromCurrency']['symbol'],
          invertSeparators: true,
          pattern: "S #.##0,00",
        );

    var toCurrency = Currencies.find(data['toCurrency']['code']) ??
        Currency.create(
          data['toCurrency']['code'],
          2,
          symbol: data['toCurrency']['symbol'],
          invertSeparators: true,
          pattern: "S #.##0,00",
        );

    var input = (data['input'] as String).replaceFirst(".", ",");

    var result = (data['result'] as String).replaceFirst(".", ",");

    return ConversionLogEntry(
      timestamp: DateTime.parse(data['timestamp']['date'] + data['timestamp']['timezone']),
      fromCurrency: fromCurrency,
      input: toCurrency.parse(input, pattern: "0,00"),
      result: toCurrency.parse(result, pattern: "0,00"),
    );
  }

  @override
  String toString() =>
      "ConversionLogEntry: " + timestamp.toString() + ": " + input.toString() + " -> " + result.toString();
}
