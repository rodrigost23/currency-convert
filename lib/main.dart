import 'package:currency_convert/widgets/keyboard_button.dart';
import 'package:currency_convert/widgets/numbers_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return MaterialApp(
      title: 'Conversor de Moedas',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Conversor de Moedas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(0),
              shape: Border(),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      ButtonBar(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.history),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                              child: Text(
                                "R\$ 1,00",
                                textAlign: TextAlign.end,
                                style: Theme.of(context).textTheme.display2,
                              ),
                            ),
                            Divider(
                              indent: 16,
                              endIndent: 16,
                              thickness: 2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
                              child: Text(
                                "\$ 4,69",
                                textAlign: TextAlign.end,
                                style: Theme.of(context)
                                    .textTheme
                                    .display2
                                    .copyWith(color: Theme.of(context).textTheme.body1.color),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ButtonBar(
              buttonTextTheme: ButtonTextTheme.normal,
              children: <Widget>[
                KeyboardButton(
                  value: "del",
                  child: Icon(Icons.backspace),
                )
              ],
            ),
            Expanded(child: NumbersGrid()),
          ],
        ),
      ),
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
