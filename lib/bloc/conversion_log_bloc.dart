import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../models/conversion_log_entry.dart';
import '../repository/converter_repository.dart';

part 'conversion_log_event.dart';
part 'conversion_log_state.dart';

class ConversionLogBloc extends Bloc<ConversionLogEvent, ConversionLogState> {
  ConverterRepository repository;

  ConversionLogBloc({@required this.repository});

  @override
  ConversionLogState get initialState => ConversionLogInitial();

  @override
  Stream<ConversionLogState> mapEventToState(
    ConversionLogEvent event,
  ) async* {
    final currentState = state;
    if (event is ConversionLogFetch) {
      try {
        if (currentState is ConversionLogInitial) {
          final entries = await repository.getConversionLog();
          yield ConversionLogLoaded(entries: entries);
          return;
        }

        if (currentState is ConversionLogLoaded) {
          final entries = await repository.getConversionLog();
          yield ConversionLogLoaded(entries: entries);
        }
      } catch (_) {
        yield ConversionLogError();
      }
    }
  }
}
