import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money2/money2.dart';

import '../bloc/converter_bloc.dart';
import '../screens/history_page.dart';
import '../widgets/keyboard_button.dart';
import '../widgets/number_fields.dart';
import '../widgets/numbers_grid.dart';
import '../repository/converter_repository.dart';

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
      child: BlocProvider(
        create: (context) => ConverterBloc(
          //TODO: Get initial conversion currencies from user prefs
          ConverterEditing(fromCurrency: Currencies.find("USD"), toCurrency: Currencies.find("BRL")),
          repository: RepositoryProvider.of<ConverterRepository>(context),
        ),
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: Card(
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
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HistoryPage()),
                                ),
                              ),
                            ],
                          ),
                          NumberFields(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: 460,
                  width: double.infinity,
                  child: Column(children: [
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: BlocBuilder<ConverterBloc, ConverterState>(builder: (context, state) {
                            return Text(
                              state is ConverterError ? (state.details ?? "") : "",
                              style: Theme.of(context)
                                  .textTheme
                                  .body2
                                  .copyWith(color: Theme.of(context).errorColor),
                            );
                          }),
                        ),
                        Spacer(),
                        KeyboardButton(
                          value: ConverterEvent.commandDelete,
                          longPressValue: ConverterEvent.commandClear,
                          child: Icon(Icons.backspace),
                        )
                      ],
                    ),
                    Expanded(child: NumbersGrid()),
                  ]))
            ],
          ),
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
