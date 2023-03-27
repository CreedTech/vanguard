part of 'movie_tabbed_cubit.dart';

abstract class MovieTabbedState extends Equatable {
  final int currentTabIndex;

  const MovieTabbedState({this.currentTabIndex = 0});

  @override
  List<Object> get props => [currentTabIndex];
}

class MovieTabbedInitial extends MovieTabbedState {}

class MovieTabChanged extends MovieTabbedState {
  final List<MovieEntity> movies;

  const MovieTabChanged({int currentTabIndex = 0, required this.movies})
      : super(currentTabIndex: currentTabIndex);

  @override
  List<Object> get props => [currentTabIndex, movies];
}

class MovieTabLoadError extends MovieTabbedState {
  final AppErrorType errorType;

  const MovieTabLoadError({
    int currentTabIndex = 0,
    required this.errorType,
  }) : super(currentTabIndex: currentTabIndex);
}

class MovieTabLoading extends MovieTabbedState {
  const MovieTabLoading({int currentTabIndex = 0})
      : super(currentTabIndex: currentTabIndex);
}

//
// part of 'movie_tabbed_cubit.dart';
//
// abstract class MovieTabbedState extends Equatable {
//   const MovieTabbedState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class MovieTabbedInitial extends MovieTabbedState {}
//
// class MovieTabLoadError extends MovieTabbedState {
//   final AppErrorType errorType;
//
//   const MovieTabLoadError(
//       this.errorType,
//       );
// }
//
// class MovieTabLoaded extends MovieTabbedState {
//   final List<MovieEntity> movies;
//   final int defaultIndex;
//
//   const MovieTabLoaded({
//     required this.movies,
//     this.defaultIndex = 0,
//   }) : assert(defaultIndex >= 0, 'defaultIndex cannot be less than 0');
//
//   @override
//   List<Object> get props => [movies, defaultIndex];
// }
//
// // class MovieTabLoading extends MovieTabbedState {
// //   const MovieTabLoading();
// // }
