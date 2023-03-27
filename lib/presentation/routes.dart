// import 'package:flutter/material.dart';
//
// import '../common/constants/route_constants.dart';
// import '../domain/entities/movie_entity.dart';
// import 'journeys/favorite/favorite_screen.dart';
// import 'journeys/home/home_screen.dart';
// import 'journeys/movie_detail/movie_detail_arguments.dart';
// import 'journeys/movie_detail/movie_detail_screen.dart';
// import 'journeys/splash/splash_screen.dart';
// import 'journeys/watch_video/watch_video_arguments.dart';
// import 'journeys/watch_video/watch_video_screen.dart';
//
// class Routes {
//   static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
//         RouteList.initial: (context) => SplashScreen(),
//         RouteList.home: (context) => HomeScreen(),
//         if (setting.arguments is MovieEntity)
//           RouteList.movieDetail: (context) => MovieDetailScreen(response: [setting.arguments] as List<MovieEntity>,),
//
//         RouteList.watchTrailer: (context) => WatchVideoScreen(
//               watchVideoArguments: setting.arguments as WatchVideoArguments,
//             ),
//         RouteList.favorite: (context) => FavoriteScreen(),
//       };
// }
