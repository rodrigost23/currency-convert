import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/conversion_log_bloc.dart';
import '../repository/converter_repository.dart';
import '../widgets/log_entry.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //ignore:close_sinks
  ConversionLogBloc _bloc;
  Completer _completer = Completer();

  @override
  void initState() {
    super.initState();
    _bloc = ConversionLogBloc(repository: RepositoryProvider.of<ConverterRepository>(context));
    _bloc.add(ConversionLogFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Histórico"),
        brightness: Theme.of(context).brightness,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor.withAlpha(240),
      ),
      body: RefreshIndicator(
        child: BlocBuilder<ConversionLogBloc, ConversionLogState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is ConversionLogLoaded) {
              if (state is! ConversionLogRefreshing) {
                _completer.complete(true);
                _completer = Completer();
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: state.entries.length,
                  separatorBuilder: (context, index) => Divider(indent: 24, endIndent: 24),
                  itemBuilder: (context, index) =>
                      index >= state.entries.length ? null : LogEntryWidget(state.entries[index]));
            } else {
              return Container();
            }
          },
        ),
        onRefresh: () {
          _bloc.add(ConversionLogFetch());
          return _completer.future;
        },
      ),
    );
  }
}
