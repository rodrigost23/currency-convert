import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';

import 'repository/converter_api_client.dart';
import 'repository/converter_repository.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
  ));

  ///
  /// Force the layout to Portrait mode
  ///
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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

    return RepositoryProvider<ConverterRepository>(
      create: (context) => ConverterApiClient(),
      child: MaterialApp(
        title: 'Conversor de Moedas',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
        ),
        home: HomePage(title: 'Conversor de Moedas'),
      ),
    );
  }
}
