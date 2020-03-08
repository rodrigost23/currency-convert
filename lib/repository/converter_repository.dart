import 'package:currency_convert/models/conversion_log_entry.dart';
import 'package:money2/money2.dart';

abstract class ConverterRepository {
  Future<Money> getConversion(Money from, Currency to);
  Future<List<ConversionLogEntry>> getConversionLog();
}
