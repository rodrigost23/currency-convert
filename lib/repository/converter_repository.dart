import 'package:money2/money2.dart';

abstract class ConverterRepository {
  Future<Money> getConversion(Money from, Currency to);
}
