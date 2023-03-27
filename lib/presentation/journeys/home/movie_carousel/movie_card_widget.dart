import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../common/constants/size_constants.dart';
import '../../../../common/extensions/size_extensions.dart';
import '../../../../data/core/api_constants.dart';
import '../../../../domain/entities/movie_entity.dart';
import '../../../../helpers/helper_utils.dart';
import '../../movie_detail/movie_detail_arguments.dart';

class MovieCardWidget extends StatelessWidget {
  final int movieId;
  final String posterPath;
  final List<MovieEntity> movie;

  const MovieCardWidget({
    Key? key,
    required this.movieId,
    required this.posterPath,
    required this.movie
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: GestureDetector(
        onTap: () => Guide.to(
          name: RouteList.detail,
          arguments: movie,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          child: CachedNetworkImage(
            imageUrl: '$posterPath',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
