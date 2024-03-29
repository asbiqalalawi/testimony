part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<TestimonyModel> testimonies;
  final bool? fullLoaded;

  HomeSuccess({
    required this.testimonies,
    this.fullLoaded,
  });

  List<Object> get props => [testimonies, fullLoaded ?? ''];
}

final class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});

  List<Object> get props => [error];
}
