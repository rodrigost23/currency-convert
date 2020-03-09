part of 'conversion_log_bloc.dart';

abstract class ConversionLogState extends Equatable {
  const ConversionLogState();
}

class ConversionLogInitial extends ConversionLogState {
  @override
  List<Object> get props => [];
}

class ConversionLogInitialLoading extends ConversionLogInitial {}

class ConversionLogLoaded extends ConversionLogState {
  final List<ConversionLogEntry> entries;

  /// Indicates if there's no more pages to search for
  final bool hasReachedMax;

  const ConversionLogLoaded({this.entries, this.hasReachedMax});

  @override
  List<Object> get props => [entries, hasReachedMax];

  ConversionLogLoaded copyWith({entries, hasReachedMax}) => ConversionLogLoaded(
        entries: entries ?? this.entries,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );
}

class ConversionLogRefreshing extends ConversionLogLoaded {
  ConversionLogRefreshing.fromState(ConversionLogLoaded state) : super(entries: List.of(state.entries));
}

class ConversionLogError extends ConversionLogState {
  final String message;

  ConversionLogError({this.message = "Erro ao obter histórico."});

  @override
  List<Object> get props => [];
}
