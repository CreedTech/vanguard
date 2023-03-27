import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vanguard/components/component_style.dart';
import '../../../../common/constants/route_constants.dart';
import '../../../../common/constants/size_constants.dart';
import '../../../../common/extensions/size_extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../components/component_theme.dart';
import '../../../../domain/entities/movie_entity.dart';
import '../../../../helpers/helper_utils.dart';
import '../../movie_detail/movie_detail_arguments.dart';
import 'movie_tab_card_widget.dart';

class MovieListViewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieListViewBuilder({Key? key, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movie = movies.map((e) => e).toList();
    return Flexible(
      fit: FlexFit.loose,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: movie
                  .asMap()
                  .map(
                      (index, value) => MapEntry(
                          index,
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              RouteList.detail,
                              arguments: MovieDetailArguments(movie),
                            );
                          },
                          child: Container(
                            height: 100.h,
                            margin: EdgeInsets.only(top: 8.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: Theme.of(context).brightness ==
                                  Brightness.dark
                                  ? colorsBlack
                                  : colorWhite,
                              border: Border.all(
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? Colors.grey.withOpacity(0.1)
                                    : borderGray,
                              ),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: SizedBox(
                                    width: 115.w,
                                    height: 100.h,
                                    child: CachedNetworkImage(
                                      // imageUrl: movie[index].source.ogImage[0].url,
                                      imageUrl: movie[index].banner,
                                      imageBuilder: (c, image) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 8.h,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 220.w,
                                        child: Text(
                                          movie[index].title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ).boldSized(14).colors(
                                            Guide.isDark(context)
                                                ? darkThemeText
                                                : colorsBlack),
                                      ),
                                      SizedBox(
                                        width: 220.w,
                                        child: Text(
                                          movie[index].description,
                                          maxLines: 2,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                        ).normalSized(12).colors(
                                          Guide.isDark(context)
                                              ? darkThemeText
                                              : colorsBlack,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6.h,
                                          horizontal: 6.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colorPrimary,
                                          borderRadius:
                                          BorderRadius.circular(5.r),
                                        ),
                                        child:
                                        Text(movie[index].category)
                                            .boldSized(8)
                                            .colors(
                                          Guide.isDark(context)
                                              ? colorWhite
                                              : colorWhite,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 210.w,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text('BY')
                                                    .boldSized(10)
                                                    .colors(colorTextGray),
                                                SizedBox(
                                                  width: 7.w,
                                                ),
                                                Text(
                                                  movie[index]
                                                      .author
                                                      .toUpperCase(),
                                                )
                                                    .boldSized(10)
                                                    .colors(colorTextGray)
                                              ],
                                            ),
                                            Text(
                                              timeago.format(
                                                movie[index].date,
                                              ),
                                            )
                                                .boldSized(10)
                                                .colors(colorTextGray),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: ClipRRect(
                          //         borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
                          //         child: CachedNetworkImage(
                          //           imageUrl: '$posterPath',
                          //           fit: BoxFit.cover,
                          //         ),
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: EdgeInsets.only(top: Sizes.dimen_4.h),
                          //       child: Text(
                          //         title.intelliTrim(),
                          //         maxLines: 1,
                          //         textAlign: TextAlign.center,
                          //         style: Theme.of(context).textTheme.bodyMedium,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ),
                      ),
              ).values.toList(),
            ),
          ),
        ),
        // ListView.separated(
        //   shrinkWrap: true,
        //   itemCount: movies.length,
        //   scrollDirection: Axis.vertical,
        //   separatorBuilder: (context, index) {
        //     return SizedBox(
        //       width: Sizes.dimen_14.w,
        //     );
        //   },
        //   itemBuilder: (context, index) {
        //     final MovieEntity movie = movies[index];
        //     return MovieTabCardWidget(
        //       movieId: movie.id,
        //       title: movie.title,
        //       posterPath: movie.banner,
        //     );
        //   },
        // ),
      ),
    );
  }
}
