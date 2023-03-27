import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vanguard/components/component_style.dart';
import 'package:vanguard/presentation/themes/theme_color.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../common/constants/route_constants.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../components/component_theme.dart';
import '../../../di/get_it.dart';
import '../../../helpers/helper_utils.dart';
import '../../blocs/movie_backdrop/movie_backdrop_cubit.dart';
import '../../blocs/movie_carousel/movie_carousel_cubit.dart';
import '../../blocs/movie_tabbed/movie_tabbed_cubit.dart';
import '../../blocs/search_movie/search_movie_cubit.dart';
import '../../main-menu/profile_screen.dart';
import '../../main-menu/search_screen.dart';
import '../../widgets/app_error_widget.dart';
import '../../widgets/movie_app_bar.dart';
import '../drawer/navigation_drawer.dart';
import '../favorite/favorite_screen.dart';
import '../loading/loading_circle.dart';
import 'movie_carousel/movie_carousel_widget.dart';
import 'movie_tabbed/movie_list_view_builder.dart';
import 'movie_tabbed/movie_tabbed_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselCubit movieCarouselCubit;
  late MovieBackdropCubit movieBackdropCubit;
  late MovieTabbedCubit movieTabbedCubit;
  late SearchMovieCubit searchMovieCubit;
  var _currentIndex = 0;
  int _cIndex = 0;

  @override
  void initState() {
    super.initState();
    movieCarouselCubit = getItInstance<MovieCarouselCubit>();
    movieBackdropCubit = movieCarouselCubit.movieBackdropCubit;
    movieTabbedCubit = getItInstance<MovieTabbedCubit>();
    searchMovieCubit = getItInstance<SearchMovieCubit>();
    movieCarouselCubit.loadCarousel();
  }

  @override
  void dispose() {
    super.dispose();
    movieCarouselCubit.close();
    movieBackdropCubit.close();
    movieTabbedCubit.close();
    searchMovieCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCarouselCubit,
        ),
        BlocProvider(
          create: (context) => movieBackdropCubit,
        ),
        BlocProvider(
          create: (context) => movieTabbedCubit,
        ),
        BlocProvider.value(
          value: searchMovieCubit,
        ),
      ],
      child: Scaffold(
        drawer: const NavigationDrawers(),
        bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: AppColor.primaryColor,
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text("Likes"),
                selectedColor: AppColor.primaryColor,
              ),

              /// Search
              SalomonBottomBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
                selectedColor: AppColor.primaryColor,
              ),

              /// Profile
              SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                selectedColor: AppColor.primaryColor,
              ),
            ]),
        body: BlocBuilder<MovieCarouselCubit, MovieCarouselState>(
          builder: (context, state) {
            if (state is MovieCarouselLoaded) {
              switch (_currentIndex) {
                case 0:
                  return LiquidPullToRefresh(
                    height: 200,
                    animSpeedFactor: 2,
                    showChildOpacityTransition: false,
                    onRefresh: () async {
                      movieCarouselCubit.loadCarousel();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: Guide.isDark(context)
                              ? [
                            colorsBlack,
                            colorsBlackGray,
                          ]
                              : [
                            colorWhite,
                            colorGray,
                          ],
                          // stops: [],
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MovieAppBar(),
                            SizedBox(height: 20.h),
                            MovieCarouselWidget(
                                    movies: state.movies,
                                    defaultIndex: state.defaultIndex,
                                  ),
                            SizedBox(height: 20.h),
                            _recommendationTextWidget(),
                            SizedBox(height: 10.h),
                            // FractionallySizedBox(
                            //   alignment: Alignment.bottomCenter,
                            //   heightFactor: 0.4,
                            //   child: MovieTabbedWidget(),
                            // ),
                            Container(
                              height: 200,
                              child: MovieTabbedWidget(),
                            ),
                            // MovieTabbedWidget(),
                            // _recommendationNews(),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                  );
                  //   Stack(
                  //   fit: StackFit.expand,
                  //   children: <Widget>[
                  //     FractionallySizedBox(
                  //       alignment: Alignment.topCenter,
                  //       heightFactor: 0.6,
                  //       child: MovieCarouselWidget(
                  //         movies: state.movies,
                  //         defaultIndex: state.defaultIndex,
                  //       ),
                  //     ),
                  //     FractionallySizedBox(
                  //       alignment: Alignment.bottomCenter,
                  //       heightFactor: 0.4,
                  //       child: MovieTabbedWidget(),
                  //     ),
                  //   ],
                  // );
                case 1:
                  return FavoriteScreen();
                case 2:
                  return SearchScreen();

                case 3:
                  return ProfileScreen();

                default:
              }
            } else if (state is MovieCarouselError) {
              return AppErrorWidget(
                onPressed: () => movieCarouselCubit.loadCarousel(),
                errorType: state.errorType,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _recommendationTextWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Recommendation").boldSized(16).colors(
                  Guide.isDark(context)
                      ? darkThemeText
                      : colorsBlack),
              GestureDetector(
                onTap: () =>{}
                //     Guide.to(
                //   name: categoryNews,
                //   arguments: CategoryNewsViewArgument(
                //     category: "All News",
                //     query: "",
                //     isKeyword: false,
                //   ),
                // )
                ,
                child: const Text("See more").boldSized(12).colors(
                    Guide.isDark(context)
                        ? colorWhite
                        : colorPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _recommendationNews() {
  //   return BlocBuilder<MovieTabbedCubit, MovieTabbedState>(
  //     builder: (context, state) {
  //       if (state is MovieTabLoaded){
  //
  //       }
  //       return
  //         SingleChildScrollView(
  //           scrollDirection: Axis.vertical,
  //           child: Padding(
  //             padding: EdgeInsets.symmetric(horizontal: 15.w),
  //             child: Column(
  //               children: <Widget>[
  //                 // if (state is MovieTabChanged)
  //                 // if (state is MovieCarouselLoaded)
  //
  //                     // final recommendation = state.recommendation?.map((e) => e).toList();
  //                    // MovieListViewBuilder(movies: state.movies)
  //
  //                 // MovieListViewBuilder(movies: state.movies),
  //                 widget.movies.isEmpty
  //                     ? Expanded(
  //                   child: Center(
  //                     child: Text(
  //                       TranslationConstants.noMovies.t(context),
  //                       textAlign: TextAlign.center,
  //                       style: Theme.of(context).textTheme.titleMedium,
  //                     ),
  //                   ),
  //                 )
  //                     : MovieListViewBuilder(movies: widget.movies),
  //                 if (state is MovieTabLoadError)
  //                   Expanded(
  //                     child: AppErrorWidget(
  //                       errorType: state.errorType,
  //                       onPressed: () => {}
  //                       //     movieTabbedCubit.movieTabChanged(
  //                       //   currentTabIndex: state.currentTabIndex,
  //                       // )
  //                       ,
  //                     ),
  //                   ),
  //                 if (state is MovieTabLoading)
  //                   Expanded(
  //                     child: Center(
  //                       child: LoadingCircle(
  //                         size: 100.w,
  //                       ),
  //                     ),
  //                   ),
  //               ],
  //             ),
  //           ),
  //         );
  //     },
  //   );
  // }
  // Widget _recommendationNews() {
  //   return
  //     BlocBuilder<MovieTabbedCubit, MovieTabbedState>(
  //     builder: (_, state) {
  //       // if (state is MovieTabLoading) {
  //       //   List loading = [1, 2, 3];
  //       //   return SingleChildScrollView(
  //       //     scrollDirection: Axis.vertical,
  //       //     child: Column(
  //       //       children: loading
  //       //           .asMap()
  //       //           .map(
  //       //             (index, value) => MapEntry(
  //       //           index,
  //       //           Padding(
  //       //             padding: EdgeInsets.symmetric(
  //       //               horizontal: 15.w,
  //       //               vertical: 5.h,
  //       //             ),
  //       //             child: Container(
  //       //               child: Text("loading"),
  //       //             ),
  //       //             // Shimmer.fromColors(
  //       //             //   baseColor: Guide.isDark(context)
  //       //             //       ? Colors.white24
  //       //             //       : Colors.black,
  //       //             //   highlightColor: darkThemeText,
  //       //             //   child: const TrendingSkeletonWidget(),
  //       //             // ),
  //       //           ),
  //       //         ),
  //       //       )
  //       //           .values
  //       //           .toList(),
  //       //     ),
  //       //   );
  //       // }
  //       if (state is MovieTabLoaded) {
  //         // final recommendation = state.movies.map((e) => e).toList();
  //         return SingleChildScrollView(
  //           scrollDirection: Axis.vertical,
  //           child:
  //           Container(
  //             height: 900,
  //               child: MovieTabbedWidget(movies: state.movies,)),
  //           // child: Padding(
  //           //   padding: EdgeInsets.symmetric(horizontal: 15.w),
  //           //   child: Column(
  //           //     children: recommendation
  //           //         .asMap()
  //           //         .map(
  //           //           (index, value) => MapEntry(
  //           //         index,
  //           //         GestureDetector(
  //           //           onTap: () => Guide.to(
  //           //             name: RouteList.detail,
  //           //             arguments: recommendation[index],
  //           //           ),
  //           //           child: Container(
  //           //             height: 100.h,
  //           //             margin: EdgeInsets.only(top: 8.h),
  //           //             decoration: BoxDecoration(
  //           //               borderRadius: BorderRadius.circular(10.r),
  //           //               color: Theme.of(context).brightness ==
  //           //                   Brightness.dark
  //           //                   ? colorsBlack
  //           //                   : colorWhite,
  //           //               border: Border.all(
  //           //                 color: Theme.of(context).brightness ==
  //           //                     Brightness.dark
  //           //                     ? Colors.grey.withOpacity(0.1)
  //           //                     : borderGray,
  //           //               ),
  //           //             ),
  //           //             child: Row(
  //           //               children: [
  //           //                 ClipRRect(
  //           //                   borderRadius: BorderRadius.circular(10.r),
  //           //                   child: SizedBox(
  //           //                     width: 115.w,
  //           //                     height: 100.h,
  //           //                     child: CachedNetworkImage(
  //           //                       // imageUrl: recommendation[index].source.ogImage[0].url,
  //           //                       imageUrl: recommendation[index].banner,
  //           //                       imageBuilder: (c, image) => Container(
  //           //                         decoration: BoxDecoration(
  //           //                           image: DecorationImage(
  //           //                             image: image,
  //           //                             fit: BoxFit.cover,
  //           //                           ),
  //           //                         ),
  //           //                       ),
  //           //                     ),
  //           //                   ),
  //           //                 ),
  //           //                 Padding(
  //           //                   padding: EdgeInsets.symmetric(
  //           //                     horizontal: 10.w,
  //           //                     vertical: 8.h,
  //           //                   ),
  //           //                   child: Column(
  //           //                     mainAxisAlignment:
  //           //                     MainAxisAlignment.spaceBetween,
  //           //                     crossAxisAlignment:
  //           //                     CrossAxisAlignment.start,
  //           //                     children: [
  //           //                       SizedBox(
  //           //                         width: 220.w,
  //           //                         child: Text(
  //           //                           recommendation[index].title,
  //           //                           maxLines: 1,
  //           //                           overflow: TextOverflow.ellipsis,
  //           //                         ).boldSized(14).colors(
  //           //                             Guide.isDark(context)
  //           //                                 ? darkThemeText
  //           //                                 : colorsBlack),
  //           //                       ),
  //           //                       SizedBox(
  //           //                         width: 220.w,
  //           //                         child: Text(
  //           //                           recommendation[index].description,
  //           //                           maxLines: 2,
  //           //                           textAlign: TextAlign.justify,
  //           //                           overflow: TextOverflow.ellipsis,
  //           //                         ).normalSized(12).colors(
  //           //                           Guide.isDark(context)
  //           //                               ? darkThemeText
  //           //                               : colorsBlack,
  //           //                         ),
  //           //                       ),
  //           //                       Container(
  //           //                         padding: EdgeInsets.symmetric(
  //           //                           vertical: 6.h,
  //           //                           horizontal: 6.w,
  //           //                         ),
  //           //                         decoration: BoxDecoration(
  //           //                           color: colorPrimary,
  //           //                           borderRadius:
  //           //                           BorderRadius.circular(5.r),
  //           //                         ),
  //           //                         child:
  //           //                         Text(recommendation[index].category)
  //           //                             .boldSized(8)
  //           //                             .colors(
  //           //                           Guide.isDark(context)
  //           //                               ? colorWhite
  //           //                               : colorWhite,
  //           //                         ),
  //           //                       ),
  //           //                       SizedBox(
  //           //                         width: 210.w,
  //           //                         child: Row(
  //           //                           mainAxisAlignment:
  //           //                           MainAxisAlignment.spaceBetween,
  //           //                           children: [
  //           //                             Row(
  //           //                               children: [
  //           //                                 const Text('BY')
  //           //                                     .boldSized(10)
  //           //                                     .colors(colorTextGray),
  //           //                                 SizedBox(
  //           //                                   width: 7.w,
  //           //                                 ),
  //           //                                 Text(
  //           //                                   recommendation[index]
  //           //                                       .author
  //           //                                       .toUpperCase(),
  //           //                                 )
  //           //                                     .boldSized(10)
  //           //                                     .colors(colorTextGray)
  //           //                               ],
  //           //                             ),
  //           //                             Text(
  //           //                               timeago.format(
  //           //                                 recommendation[index].date,
  //           //                               ),
  //           //                             )
  //           //                                 .boldSized(10)
  //           //                                 .colors(colorTextGray),
  //           //                           ],
  //           //                         ),
  //           //                       ),
  //           //                     ],
  //           //                   ),
  //           //                 ),
  //           //               ],
  //           //             ),
  //           //           ),
  //           //         ),
  //           //       ),
  //           //     )
  //           //         .values
  //           //         .toList(),
  //           //   ),
  //           // ),
  //         );
  //       }
  //       else if (state is MovieTabLoadError) {
  //         return AppErrorWidget(
  //           onPressed: () => movieCarouselCubit.loadCarousel(),
  //           errorType: state.errorType,
  //         );
  //       }
  //       return Container(
  //         height: 100.h,
  //         child: Text("Error"),
  //       );
  //     },
  //   );
  // }


}
