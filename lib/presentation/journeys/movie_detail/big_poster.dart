import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/num_extensions.dart';
import '../../../common/extensions/size_extensions.dart';
import '../../../common/screenutil/screenutil.dart';
import '../../../data/core/api_constants.dart';
import '../../../domain/entities/movie_detail_entity.dart';
import '../../../domain/entities/movie_entity.dart';
import '../../themes/theme_text.dart';
import 'movie_detail_app_bar.dart';

class BigPoster extends StatelessWidget {
  final MovieEntity response;

  const BigPoster({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.3),
                Theme.of(context).primaryColor,
              ],
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: '${response.banner}',
            width: screenutil.screenWidth,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ListTile(
            title: Text(
              response.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text(
              response.date.toString(),
              style: Theme.of(context).textTheme.greySubtitle1,
            ),
            trailing: Text(
              response.category,
              style: Theme.of(context).textTheme.violetHeadline6,
            ),
          ),
        ),
        Positioned(
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
          top: screenutil.statusBarHeight + Sizes.dimen_4.h,
          child: MovieDetailAppBar(movieDetailEntity: response),
        ),
      ],
    );
  }
}
