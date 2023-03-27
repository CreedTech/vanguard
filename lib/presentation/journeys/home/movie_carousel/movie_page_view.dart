import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vanguard/components/component_style.dart';
import 'package:vanguard/presentation/themes/theme_color.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../common/extensions/size_extensions.dart';
import '../../../../components/component_theme.dart';
import '../../../../domain/entities/movie_entity.dart';
import '../../../../helpers/helper_utils.dart';
import '../../../blocs/movie_backdrop/movie_backdrop_cubit.dart';
import 'animated_movie_card_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class MoviePageView extends StatefulWidget {
  final List<MovieEntity> movies;
  final int initialPage;

  const MoviePageView({
    Key? key,
    required this.movies,
    this.initialPage = 0,
  })  : assert(initialPage >= 0, 'initialPage cannot be less than 0'),
        super(key: key);

  @override
  _MoviePageViewState createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  late PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: false,
      // viewportFraction: 1.7,
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 250.h,
      width: 360.w,
      decoration: BoxDecoration(
        color: Guide.isDark(context) ? colorsBlack : colorWhite,
        boxShadow: Guide.isDark(context)
            ? [
                const BoxShadow(
                  color: textGray,
                  offset: Offset(
                    0.5,
                    0.5,
                  ),
                  blurRadius: 0.5,
                  spreadRadius: 0.1,
                )
              ]
            : [],
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.movies.length,
        // onPageChanged: (index) {
        //   setState(() {
        //     _cIndex = index;
        //   });
        // },
        onPageChanged: (index) {
          BlocProvider.of<MovieBackdropCubit>(context)
              .backdropChanged(widget.movies[index]);
        },
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () => Guide.to(
              name: RouteList.detail,
              arguments: widget.movies[index],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: CachedNetworkImage(
                    // imageUrl: trending[index].source.ogImage[0].url,
                    imageUrl: widget.movies[index].banner,
                    imageBuilder: (c, image) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                          colorFilter:
                              Theme.of(context).brightness == Brightness.dark
                                  ? ColorFilter.mode(
                                      Colors.black.withOpacity(0.3),
                                      BlendMode.softLight,
                                    )
                                  : ColorFilter.mode(
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.softLight,
                                    ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.h,
                  right: 16.w,
                  left: 16.w,
                  child: Container(
                    width: 300.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Guide.isDark(context)
                          ? colorsBlack
                          : colorWhite,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Guide.isDark(context)
                            ? darkThemeText
                            : borderGray,
                        width: 0.3,
                        style: BorderStyle.solid,
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 11.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 260.w,
                                child: Text(
                                  widget.movies[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ).boldSized(18)
                                    .colors(
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? darkThemeText
                                      : colorsBlack,
                                )
                                ,
                              ),
                              // Column(
                              //   crossAxisAlignment:
                              //       CrossAxisAlignment.start,
                              //   children: [
                              //     Icon(
                              //       Icons.remove_red_eye_outlined,
                              //       size: 24.h,
                              //       color: colorPrimary,
                              //     ),
                              //     Text("${Random().nextInt(999)} K")
                              //         .boldSized(11)
                              //         .colors(colorPrimary),
                              //   ],
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 9.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text('BY').boldSized(10)
                                  .colors(colorTextGray)
                                  ,
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  Text(widget.movies[index].author
                                          .toUpperCase())
                                      .boldSized(10)
                                  .colors(colorTextGray)
                                ],
                              ),
                              Text(
                                timeago.format(
                                  widget.movies[index].date,
                                ),
                              ).boldSized(10)
                              .colors(colorTextGray)
                              ,
                            ],
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 15.h,
                  left: 15.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 6.h,
                      horizontal: 17.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(widget.movies[index].category).boldSized(11)
                        .colors(
                      Guide.isDark(context) ? colorWhite : colorWhite,
                    )
                    ,
                  ),
                ),
                // Positioned(
                //   top: 16.h,
                //   right: 16.w, // Position from Right
                //   child: SizedBox(
                //     height: 10.h,
                //     child: ListView.builder(
                //       itemCount: widget.movies.length,
                //       scrollDirection: Axis.horizontal,
                //       shrinkWrap: true,
                //       physics: const ScrollPhysics(),
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.all(4.0),
                //           child: Container(
                //             width: 15,
                //             decoration: _cIndex == index
                //                 ? BoxDecoration(
                //               color: colorPrimary,
                //               // Selected Slider Indicator Color
                //               borderRadius:
                //               BorderRadius.circular(15.r),
                //             )
                //                 : BoxDecoration(
                //               color: Guide.isDark(context)
                //                   ? darkThemeText
                //                   : colorGray,
                //               // Selected Slider Indicator Color
                //               borderRadius:
                //               BorderRadius.circular(15.r),
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
    //   Container(
    //   margin: EdgeInsets.symmetric(vertical: 6.h),
    //   height: screenutil.screenHeight * 0.35,
    //   child: PageView.builder(
    //     controller: _pageController,
    //     itemBuilder: (context, index) {
    //       final MovieEntity movie = widget.movies[index];
    //       return AnimatedBuilder(
    //         animation: _pageController!,
    //         builder: (context, child) {
    //           double value = 1;
    //           if (_pageController!.position.haveDimensions) {
    //             value = (_pageController!.page ?? 0) - index;
    //             value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
    //             return Align(
    //               alignment: Alignment.topCenter,
    //               child: Container(
    //                 height: Curves.easeIn.transform(value) *
    //                     screenutil.screenHeight *
    //                     0.35,
    //                 width: 300.w,
    //                 child: child,
    //               ),
    //             );
    //           } else {
    //             return Align(
    //               alignment: Alignment.topCenter,
    //               child: Container(
    //                 height:
    //                 Curves.easeIn.transform(index == 0 ? value : value * 0.5) *
    //                     screenutil.screenHeight *
    //                     0.35,
    //                 width: 230.w,
    //                 child: child,
    //               ),
    //             );
    //           }
    //         },
    //         child: Material(
    //           elevation: 32,
    //           borderRadius: BorderRadius.circular(16.w),
    //           child: GestureDetector(
    //             onTap: () => Guide.to(
    //               name: RouteList.detail,
    //               arguments: movie,
    //             ),
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(16.w),
    //               child: CachedNetworkImage(
    //                 imageUrl: movie.banner,
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //         ),
    //         // MovieCardWidget(
    //         //   movieId: movieId,
    //         //   posterPath: posterPath, movie: movie,
    //         // ),
    //       );
    //       //   AnimatedMovieCardWidget(
    //       //   index: index,
    //       //   pageController: _pageController!,
    //       //   movieId: movie.id,
    //       //   posterPath: movie.banner,
    //       //   movie: widget.movies,
    //       // );
    //     },
    //     pageSnapping: true,
    //     itemCount: widget.movies.length,
    //     onPageChanged: (index) {
    //       BlocProvider.of<MovieBackdropCubit>(context)
    //           .backdropChanged(widget.movies[index]);
    //     },
    //   ),
    // );
  }
}
