import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/constants/route_constants.dart';
import '../../../../common/constants/size_constants.dart';
import '../../../../common/extensions/size_extensions.dart';
import '../../../../common/screenutil/screenutil.dart';
import '../../../../domain/entities/movie_entity.dart';
import '../../../../helpers/helper_utils.dart';
import 'movie_card_widget.dart';

class AnimatedMovieCardWidget extends StatelessWidget {
  final int index;
  final int movieId;
  final String posterPath;
  final List<MovieEntity> movie;
  final PageController pageController;

  const AnimatedMovieCardWidget({
    Key? key,
    required this.index,
    required this.movieId,
    required this.posterPath,
    required this.movie,
    required this.pageController,
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



// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../common/constants/route_constants.dart';
// import '../../../../common/constants/size_constants.dart';
// import '../../../../common/extensions/size_extensions.dart';
// import '../../../../common/screenutil/screenutil.dart';
// import '../../../../domain/entities/movie_entity.dart';
// import '../../../../helpers/helper_utils.dart';
// import 'movie_card_widget.dart';
//
// class AnimatedMovieCardWidget extends StatelessWidget {
//   final int index;
//   final int movieId;
//   final String posterPath;
//   final List<MovieEntity> movie;
//   final PageController pageController;
//
//   const AnimatedMovieCardWidget({
//     Key? key,
//     required this.index,
//     required this.movieId,
//     required this.posterPath,
//     required this.movie,
//     required this.pageController,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       AnimatedBuilder(
//         animation: pageController,
//         builder: (context, child) {
//           double value = 1;
//           if (pageController.position.haveDimensions) {
//             value = (pageController.page ?? 0) - index;
//             value = (1 - (value.abs() * 0.1)).clamp(0.0, 1.0);
//             return Align(
//               alignment: Alignment.topCenter,
//               child: Container(
//                 height: Curves.easeIn.transform(value) *
//                     screenutil.screenHeight *
//                     0.35,
//                 width: Sizes.dimen_230.w,
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
//                 width: Sizes.dimen_230.w,
//                 child: child,
//               ),
//             );
//           }
//         },
//         child: Material(
//           elevation: 32,
//           borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
//           child: GestureDetector(
//             onTap: () => Guide.to(
//               name: RouteList.detail,
//               arguments: movie,
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
//               child: CachedNetworkImage(
//                 imageUrl: '$posterPath',
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
//   }
// }
