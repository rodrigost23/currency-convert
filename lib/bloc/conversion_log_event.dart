part of 'conversion_log_bloc.dart';

abstract class ConversionLogEvent extends Equatable {
  const ConversionLogEvent();

  @override
  List<Object> get props => [];
}

class ConversionLogFetch extends ConversionLogEvent {}
