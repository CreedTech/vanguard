import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/app_error.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../../domain/entities/no_params.dart';
import '../../../domain/usecases/get_coming_soon.dart';
import '../../../domain/usecases/get_playing_now.dart';
import '../../../domain/usecases/get_popular.dart';

part 'movie_tabbed_state.dart';

class MovieTabbedCubit extends Cubit<MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabbedCubit({
    required this.getPopular,
    required this.getPlayingNow,
    required this.getComingSoon,
  }) : super(MovieTabbedInitial());

  void movieTabChanged({int currentTabIndex = 0}) async {
    emit(MovieTabLoading(currentTabIndex: currentTabIndex));
    late Either<AppError, List<MovieEntity>> moviesEither;
    print('before making api call $currentTabIndex');
    switch (currentTabIndex) {
      case 0:
        moviesEither = await getPopular(NoParams());
        break;
      case 1:
        moviesEither = await getPlayingNow(NoParams());
        break;
      case 2:
        moviesEither = await getComingSoon(NoParams());
        break;
    }
    emit(moviesEither.fold(
      (l) => MovieTabLoadError(
        currentTabIndex: currentTabIndex,
        errorType: l.appErrorType,
      ),
      (movies) {
        print('returning state making api call $currentTabIndex');
        return MovieTabChanged(
          currentTabIndex: currentTabIndex,
          movies: movies,
        );
      },
    ));
  }
}



// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
//
// import '../../../domain/entities/app_error.dart';
// import '../../../domain/entities/movie_entity.dart';
// import '../../../domain/entities/no_params.dart';
// import '../../../domain/usecases/get_coming_soon.dart';
// import '../../../domain/usecases/get_playing_now.dart';
// import '../../../domain/usecases/get_popular.dart';
// import '../loading/loading_cubit.dart';
// import '../movie_backdrop/movie_backdrop_cubit.dart';
//
// part 'movie_tabbed_state.dart';
//
// class MovieTabbedCubit extends Cubit<MovieTabbedState> {
//   final GetPopular getPopular;
//   final MovieBackdropCubit movieBackdropCubit;
//   // final GetPlayingNow getPlayingNow;
//   // final GetComingSoon getComingSoon;
//   final LoadingCubit loadingCubit;
//
//   MovieTabbedCubit({
//     required this.getPopular,
//     // required this.getPlayingNow,
//     // required this.getComingSoon,
//     required this.movieBackdropCubit,
//     required this.loadingCubit,
//   }) : super(MovieTabbedInitial());
//
//   // void movieTabChanged({int currentTabIndex = 0}) async {
//   //   emit(MovieTabLoading(currentTabIndex: currentTabIndex));
//   //   late Either<AppError, List<MovieEntity>> moviesEither;
//   //   print('before making api call $currentTabIndex');
//   //   switch (currentTabIndex) {
//   //     case 0:
//   //       moviesEither = await getPopular(NoParams());
//   //       break;
//   //     case 1:
//   //       moviesEither = await getPlayingNow(NoParams());
//   //       break;
//   //     case 2:
//   //       moviesEither = await getComingSoon(NoParams());
//   //       break;
//   //   }
//   //   emit(moviesEither.fold(
//   //     (l) => MovieTabLoadError(
//   //       currentTabIndex: currentTabIndex,
//   //       errorType: l.appErrorType,
//   //     ),
//   //     (movies) {
//   //       print('returning state making api call $currentTabIndex');
//   //       return MovieTabChanged(
//   //         currentTabIndex: currentTabIndex,
//   //         movies: movies,
//   //       );
//   //     },
//   //   ));
//   // }
//
//   void loadCarousel({int defaultIndex = 0}) async {
//     loadingCubit.show();
//     final moviesEither = await getPopular(NoParams());
//     emit(moviesEither.fold(
//           (l) => MovieTabLoadError(l.appErrorType),
//           (movies) {
//         movieBackdropCubit.backdropChanged(movies[defaultIndex]);
//         return MovieTabLoaded(
//           movies: movies,
//           defaultIndex: defaultIndex,
//         );
//       },
//     ));
//     loadingCubit.hide();
//   }
// }
