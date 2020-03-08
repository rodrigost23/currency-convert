import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money2/money2.dart';

import 'screens/home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Register currencies
    // TODO: Get these from server?
    var currencyPattern = "S #.##0,00";
    Currencies.registerList([
      // US Dollar
      Currency.create('USD', 2, symbol: "US\$", invertSeparators: true, pattern: currencyPattern),
      // British Pound Sterling
      Currency.create('GBP', 2, symbol: '£', invertSeparators: true, pattern: currencyPattern),
      // Euro
      Currency.create('EUR', 2, symbol: '€', invertSeparators: true, pattern: currencyPattern),
      // Brazilian Real
      Currency.create('BRL', 2, symbol: 'R\$', invertSeparators: true, pattern: currencyPattern),
    ]);

    return MaterialApp(
      title: 'Conversor de Moedas',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Conversor de Moedas'),
    );
  }
}
