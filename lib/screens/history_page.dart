import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/conversion_log_bloc.dart';
import '../repository/converter_repository.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //ignore:close_sinks
  ConversionLogBloc _bloc;

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
              return ListView.builder(
                itemBuilder: (context, index) =>
                    index >= state.entries.length ? null : Text(state.entries[index].toString()),
              );
            } else {
              return Container();
            }
          },
        ),
        onRefresh: () {
          // TODO: return real Future
          return Future.value(true);
        },
      ),
    );
  }
}
