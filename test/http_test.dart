import 'package:currency_convert/repository/converter_api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:money2/money2.dart';

void main() {
  test('http', () async {
    var client = ConverterApiClient();
    var result = await client.getConversion(Money.fromInt(100, Currency.create("USD", 2)), Currency.create("BRL", 2));
    debugPrint(result.toString());
  });
}
