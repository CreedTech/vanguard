// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../common/constants/route_constants.dart';
// import '../../../../common/constants/size_constants.dart';
// import '../../../../common/extensions/size_extensions.dart';
// import '../../../../common/extensions/string_extensions.dart';
// import '../../../../components/component_theme.dart';
// import '../../../../data/core/api_constants.dart';
// import '../../../../domain/entities/movie_entity.dart';
// import '../../movie_detail/movie_detail_arguments.dart';
//
// class MovieTabCardWidget extends StatelessWidget {
//   final int movieId;
//   final String title, posterPath;
//   final List<MovieEntity>? movie;
//
//   const MovieTabCardWidget({
//     Key? key,
//     required this.movieId,
//     required this.title,
//     required this.posterPath,
//     this.movie
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).pushNamed(
//           RouteList.detail,
//           arguments: MovieDetailArguments(movie!),
//         );
//       },
//       child: Container(
//         height: 100.h,
//         margin: EdgeInsets.only(top: 8.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.r),
//           color: Theme.of(context).brightness ==
//               Brightness.dark
//               ? colorsBlack
//               : colorWhite,
//           border: Border.all(
//             color: Theme.of(context).brightness ==
//                 Brightness.dark
//                 ? Colors.grey.withOpacity(0.1)
//                 : borderGray,
//           ),
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10.r),
//               child: SizedBox(
//                 width: 115.w,
//                 height: 100.h,
//                 child: CachedNetworkImage(
//                   // imageUrl: recommendation[index].source.ogImage[0].url,
//                   imageUrl: recommendation[index].banner,
//                   imageBuilder: (c, image) => Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: image,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 10.w,
//                 vertical: 8.h,
//               ),
//               child: Column(
//                 mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment:
//                 CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: 220.w,
//                     child: Text(
//                       recommendation[index].title,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ).boldSized(14).colors(
//                         Guide.isDark(context)
//                             ? darkThemeText
//                             : colorsBlack),
//                   ),
//                   SizedBox(
//                     width: 220.w,
//                     child: Text(
//                       recommendation[index].description,
//                       maxLines: 2,
//                       textAlign: TextAlign.justify,
//                       overflow: TextOverflow.ellipsis,
//                     ).normalSized(12).colors(
//                       Guide.isDark(context)
//                           ? darkThemeText
//                           : colorsBlack,
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 6.h,
//                       horizontal: 6.w,
//                     ),
//                     decoration: BoxDecoration(
//                       color: colorPrimary,
//                       borderRadius:
//                       BorderRadius.circular(5.r),
//                     ),
//                     child:
//                     Text(recommendation[index].category)
//                         .boldSized(8)
//                         .colors(
//                       Guide.isDark(context)
//                           ? colorWhite
//                           : colorWhite,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 210.w,
//                     child: Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             const Text('BY')
//                                 .boldSized(10)
//                                 .colors(colorTextGray),
//                             SizedBox(
//                               width: 7.w,
//                             ),
//                             Text(
//                               recommendation[index]
//                                   .author
//                                   .toUpperCase(),
//                             )
//                                 .boldSized(10)
//                                 .colors(colorTextGray)
//                           ],
//                         ),
//                         Text(
//                           timeago.format(
//                             recommendation[index].date,
//                           ),
//                         )
//                             .boldSized(10)
//                             .colors(colorTextGray),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // Column(
//       //   crossAxisAlignment: CrossAxisAlignment.center,
//       //   children: <Widget>[
//       //     Expanded(
//       //       child: ClipRRect(
//       //         borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
//       //         child: CachedNetworkImage(
//       //           imageUrl: '$posterPath',
//       //           fit: BoxFit.cover,
//       //         ),
//       //       ),
//       //     ),
//       //     Padding(
//       //       padding: EdgeInsets.only(top: Sizes.dimen_4.h),
//       //       child: Text(
//       //         title.intelliTrim(),
//       //         maxLines: 1,
//       //         textAlign: TextAlign.center,
//       //         style: Theme.of(context).textTheme.bodyMedium,
//       //       ),
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// }
