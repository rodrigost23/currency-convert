import 'dart:async';

import 'package:currency_convert/models/conversion_log_entry.dart';
import 'package:dio/dio.dart';
import 'package:money2/money2.dart';

import 'converter_repository.dart';

class ConverterApiClient implements ConverterRepository {
  static final baseOptions = BaseOptions(baseUrl: "http://192.168.1.2:8080");

  final Dio dio;

  ConverterApiClient() : this.dio = Dio(baseOptions);

  @override
  Future<Money> getConversion(Money from, Currency to) async {
    var response =
        await dio.get("/convert/" + from.currency.code + "/" + to.code + "/" + _formatMoneyToSend(from));
    if (response.statusCode == 200) {
      return _parseMoneyReceived(to, response.data['data']);
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ConversionLogEntry>> getConversionLog() async {
    var response = await dio.get("/convert/log");
    if (response.statusCode == 200) {
      return (response.data['data'] as List).map((obj) => ConversionLogEntry.fromJson(obj)).toList();
    } else {
      throw Exception();
    }
  }

  String _formatMoneyToSend(Money money) =>
      money.format("0" + money.currency.decimalSeparator + "00").replaceFirst(",", ".");

  Money _parseMoneyReceived(Currency currency, String value) => currency.parse(
        value.replaceFirst(".", currency.decimalSeparator),
        pattern: "0" + currency.decimalSeparator + "00",
      );
}
