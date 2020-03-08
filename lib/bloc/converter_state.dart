part of 'converter_bloc.dart';

abstract class ConverterState extends Equatable {
  const ConverterState();
}

class ConverterInitial extends ConverterState {
  @override
  List<Object> get props => [];
}
