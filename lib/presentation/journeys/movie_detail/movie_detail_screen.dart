import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:vanguard/components/component_style.dart';
import 'package:vanguard/domain/entities/movie_entity.dart';
import 'package:vanguard/presentation/themes/theme_color.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../components/component_theme.dart';
import '../../../helpers/helper_utils.dart';
import '../../blocs/favorite/favorite_cubit.dart';
import 'big_poster.dart';

class MovieDetailScreen extends StatefulWidget {
  final List<MovieEntity> response;

  const MovieDetailScreen({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  // late MovieDetailCubit _movieDetailCubit;
  // late CastCubit _castCubit;
  // late VideosCubit _videosCubit;
  // late FavoriteCubit _favoriteCubit;

  // @override
  // void initState() {
  //   super.initState();
  //   _movieDetailCubit = getItInstance<MovieDetailCubit>();
  //   // _castCubit = _movieDetailCubit.castBloc;
  //   // _videosCubit = _movieDetailCubit.videosCubit;
  //   _favoriteCubit = _movieDetailCubit.favoriteCubit;
  //   // _movieDetailCubit.loadMovieDetail(widget.response.movieId);
  // }

  // @override
  // void dispose() {
  //   // _movieDetailCubit.close();
  //   // _castCubit.close();
  //   // _videosCubit.close();
  //   _favoriteCubit.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FavoriteCubit, FavoriteState>(
        listener: (_, state) {},
        child: CustomScrollView(
          slivers :[
            SliverAppBar(
              expandedHeight: 300.h,
              floating: true,
              pinned: true,
              // title: Container(
              //   padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              //   decoration: BoxDecoration(
              //     color: Guide.isDark(context) ? colorsBlack : colorWhite,
              //     borderRadius: BorderRadius.circular(10.r),
              //   ),
              //   child: Text(
              //     Uri.parse(response[0].link).host,
              //   )
              //       .normalSized(15)
              //       .colors(Guide.isDark(context) ? colorWhite : colorPrimary),
              // ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Guide.isDark(context) ? colorsBlack : colorWhite,
              leading: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Guide.isDark(context) ? colorsBlack : colorWhite,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.h),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color:
                      Guide.isDark(context) ? colorPrimary : colorPrimary,
                    ),
                  ),
                ),
              ),

              actions: [
                Container(
                    decoration: BoxDecoration(
                      color: Guide.isDark(context) ? colorsBlack : colorWhite,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    margin:
                    EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                    child: IconButton(
                      onPressed: () {
                        // Share.share(
                        //   response[0].link,
                        //   subject: response[0].title,
                        // );
                      },
                      icon: Icon(
                        Icons.share_outlined,
                        color:
                        Guide.isDark(context) ? colorPrimary : colorPrimary,
                      ),
                    )),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.symmetric(horizontal: 10.w),
                collapseMode: CollapseMode.parallax,
                background: SizedBox(
                  width: 120.w,
                  height: 100.h,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        // imageUrl: response[0].source.ogImage[0].url,
                        imageUrl: widget.response[0].banner,
                        imageBuilder: (c, image) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image,
                              fit: BoxFit.cover,
                              colorFilter:
                              Guide.isDark(context)
                                  ? ColorFilter.mode(
                                Colors.black.withOpacity(0.9),
                                BlendMode.softLight,
                              )
                                  :
                              ColorFilter.mode(
                                Colors.black.withOpacity(0.8),
                                BlendMode.softLight,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -1,
                        right: 0,
                        left: 0,
                        child: Column(
                          children: [
                            Container(
                              height: 15.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                    Brightness.dark
                                    ? colorsBlack
                                    : colorWhite,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.r),
                                  topRight: Radius.circular(25.r),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 170.w, vertical: 12.h),
                                child: Divider(
                                  color: Theme.of(context).brightness ==
                                      Brightness.dark
                                      ? colorWhite
                                      : borderGray,
                                  thickness: 3.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Guide.isDark(context) ? colorsBlack : colorWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 55.h,
                        padding: EdgeInsets.symmetric(vertical: 4.w),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 350.w,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Article By")
                                          .normalSized(13)
                                          .colors(
                                        Guide.isDark(context)
                                            ? darkThemeText
                                            : colorTextGray
                                        ,
                                      )
                                      ,
                                      Text(
                                        DateFormat.yMMMMEEEEd()
                                            .format(widget.response[0].date),
                                      )
                                          .normalSized(13).colors(
                                        Guide.isDark(context)
                                            ? darkThemeText
                                            : colorTextGray,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 350.w,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        widget.response[0].author.toUpperCase(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                          .boldSized(17).colors(
                                        Guide.isDark(context)
                                            ? darkThemeText
                                            : colorsBlack,
                                      )
                                      ,
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6.h,
                                          horizontal: 6.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius:
                                          BorderRadius.circular(5.r),
                                        ),
                                        child: Text(widget.response[0].category)
                                            .boldSized(8)
                                            .colors(
                                          Guide.isDark(context)
                                              ? colorWhite
                                              : colorWhite,
                                        )
                                        ,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        widget.response[0].title,
                      ).blackSized(20)
                          .colors(
                        Guide.isDark(context) ? darkThemeText : colorsBlack,
                      )
                      ,
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        child: Text(
                          widget.response[0].description,
                        ).normalSized(13)
                            .colors(
                          Guide.isDark(context)
                              ? darkThemeText
                              : colorTextGray,
                        )
                        ,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          // _launchInBrowser(Uri.parse(response[0].link));
                        },
                        child: Container(
                          child: Text(
                            widget.response[0].link,
                          ).normalSized(10)
                              .colors(Guide.isDark(context)
                              ? colorPrimary
                              : colorPrimary)
                          ,
                        ),
                      ),
                      SizedBox(
                        height: 70.h,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
          // child: SingleChildScrollView(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       BigPoster(
          //         response: widget.response[0],
          //       ),
          //       Padding(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: Sizes.dimen_16.w,
          //           vertical: Sizes.dimen_8.h,
          //         ),
          //         child: Text(
          //           widget.response[0].description ?? '',
          //           style: Theme.of(context).textTheme.bodyMedium,
          //         ),
          //       ),
          //       // Padding(
          //       //   padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
          //       //   child: Text(
          //       //     TranslationConstants.cast.t(context),
          //       //     style: Theme.of(context).textTheme.titleLarge,
          //       //   ),
          //       // ),
          //       // CastWidget(),
          //       // VideosWidget(videosCubit: _videosCubit),
          //     ],
          //   ),
          // ),
        ),
        // builder: (context, state) {
        //   if (state is MovieDetailLoaded) {
        //     // final movieDetail = state.movieDetailEntity;
        //     return SingleChildScrollView(
        //       child: Column(
        //         mainAxisSize: MainAxisSize.min,
        //         crossAxisAlignment: CrossAxisAlignment.stretch,
        //         children: [
        //           BigPoster(
        //             movie: movieDetail,
        //           ),
        //           Padding(
        //             padding: EdgeInsets.symmetric(
        //               horizontal: Sizes.dimen_16.w,
        //               vertical: Sizes.dimen_8.h,
        //             ),
        //             child: Text(
        //               movieDetail.description ?? '',
        //               style: Theme.of(context).textTheme.bodyMedium,
        //             ),
        //           ),
        //           Padding(
        //             padding:
        //                 EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
        //             child: Text(
        //               TranslationConstants.cast.t(context),
        //               style: Theme.of(context).textTheme.titleLarge,
        //             ),
        //           ),
        //           // CastWidget(),
        //           // VideosWidget(videosCubit: _videosCubit),
        //         ],
        //       ),
        //     );
        //   } else if (state is MovieDetailError) {
        //     return Container();
        //   }
        //   return SizedBox.shrink();
        // },
      ),
    );
  }
}
