import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanguard/di/get_it.dart';
import 'package:vanguard/domain/entities/movie_entity.dart';
import 'package:vanguard/presentation/blocs/favorite/favorite_cubit.dart';

import '../common/constants/route_constants.dart';
import '../presentation/journeys/home/home_screen.dart';
import '../presentation/journeys/movie_detail/movie_detail_screen.dart';
import '../presentation/journeys/splash/splash_screen.dart';
import '../components/component_route_animtaion.dart';

class RouterGenerator {
  Route<dynamic>? generate(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteList.initial:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
          settings: const RouteSettings(name: RouteList.initial),
        );
      case RouteList.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: const RouteSettings(name: RouteList.home),
        );
      // case searchNews:
      //   return CustomPageRouteBuilder(
      //     BlocProvider(
      //       create: (context) => sl<ExploreNewsBloc>()
      //         ..add(
      //           const ExploreSearchNews(query: "entertainment", page: 1),
      //         ),
      //       child: const SearchNewsView(),
      //     ),
      //     ComponentPageTransitionAnimation.slideRight,
      //     const RouteSettings(name: searchNews),
      //   );

      case RouteList.detail:
        if (arguments is MovieEntity) {
          return CustomPageRouteBuilder(
            BlocProvider(
              create: (_) => getItInstance<FavoriteCubit>(),
              child: MovieDetailScreen(response: [arguments]),
            ),
            ComponentPageTransitionAnimation.scale,
            const RouteSettings(name: RouteList.detail),
          );
        }
        break;

      // case categoryNews:
      //   if (arguments is CategoryNewsViewArgument) {
      //     if (arguments.isKeyword) {
      //       return CustomPageRouteBuilder(
      //         BlocProvider(
      //           create: (context) => sl<CategoryNewsBloc>()
      //             ..add(
      //               CategoryNewsGetByHeadlines(
      //                 category: arguments.category,
      //                 limit: 20,
      //                 page: 1,
      //                 query: arguments.query,
      //               ),
      //             ),
      //           child: CategoryNewsView(category: arguments),
      //         ),
      //         ComponentPageTransitionAnimation.slideRight,
      //         const RouteSettings(name: categoryNews),
      //       );
      //     }
      //     return CustomPageRouteBuilder(
      //       BlocProvider(
      //         create: (context) => sl<CategoryNewsBloc>()
      //           ..add(
      //             CategoryNewsGetByHeadlines(
      //               category: arguments.category,
      //               limit: 20,
      //               page: 1,
      //               query: arguments.query,
      //             ),
      //           ),
      //         child: CategoryNewsView(category: arguments),
      //       ),
      //       ComponentPageTransitionAnimation.slideRight,
      //       const RouteSettings(name: categoryNews),
      //     );
      //   }
      //   break;

      // case contactUs:
      //   return CustomPageRouteBuilder(
      //     const ContactPage(),
      //     ComponentPageTransitionAnimation.scale,
      //     const RouteSettings(name: detail),
      //   );
    }
    return null;
  }
}

class CustomPageRouteBuilder extends PageRouteBuilder<dynamic> {
  final Widget? page;
  final ComponentPageTransitionAnimation? transitionAnimation;
  final RouteSettings? routeSettings;

  CustomPageRouteBuilder(
      this.page, this.transitionAnimation, this.routeSettings)
      : super(
          settings: routeSettings,
          pageBuilder:
              (final context, final animation, final secondaryAnimation) =>
                  page!,
          transitionsBuilder: (final context, final animation,
                  final secondaryAnimation, final child) =>
              ComponentRouteAnimation.getAnimation(
            context,
            animation,
            secondaryAnimation,
            child,
            transitionAnimation!,
          ),
        );
}
