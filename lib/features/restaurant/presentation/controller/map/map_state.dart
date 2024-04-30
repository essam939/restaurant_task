part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final MapResponse mapResponse;
  MapLoaded({required this.mapResponse});
  @override
  List<Object> get props => [];
}

class MapError extends MapState {
  final ErrorMessageModel errorMessage;

  MapError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
