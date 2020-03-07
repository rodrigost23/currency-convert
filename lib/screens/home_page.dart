import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/keyboard_button.dart';
import '../widgets/numbers_grid.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
