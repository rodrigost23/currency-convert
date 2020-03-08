import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'converter_event.dart';
part 'converter_state.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  @override
  ConverterState get initialState => ConverterInitial();

  @override
  Stream<ConverterState> mapEventToState(
    ConverterEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
