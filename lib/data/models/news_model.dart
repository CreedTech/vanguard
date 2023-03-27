// import 'package:json_annotation/json_annotation.dart';
//
// import '../../domain/entitites/news_entities.dart';
// import 'article_model.dart';
// part 'news_model.g.dart';
//
// // List<NewsModel> modelUserFromJson(String str) => List<NewsModel>.from(
// //     json.decode(str).map((x) => NewsModel.fromJson(x)));
// // String modelUserToJson(List<NewsModel> data) =>
// //     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// @JsonSerializable()
// class NewsModel {
//   final String status;
//   @JsonKey(name: "totalResults")
//   final int total;
//   List<ArticleModel> articles;
//
//   NewsModel({
//     required this.status,
//     required this.total,
//     required this.articles,
//     // this.img,
//     // this.date,
//     // this.content,
//   });
//
//   NewsEntities toEntity() => NewsEntities(
//         status: status,
//         total: total,
//         articles: articles
//             .map(
//               (e) => e.toEntity(),
//             )
//             .toList(),
//       );
//
//   factory NewsModel.fromJson(Map<String, dynamic> json) =>
//       _$NewsModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$NewsModelToJson(this);
//
// // factory NewsModel.fromJson(Map<dynamic, dynamic> json) => NewsModel(
// //   status: json["status"],
// //   total: json['totalResults'],
// //   // yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
// //     articles: List<ArticleModel>.from(json["articles"].map((x) => ArticleModel.fromJson(x)))
// // );
// //
// // Map<dynamic, dynamic> toJson() => {
// //   "status": status,
// //   "total": total.toString(),
// //   // "yoast_head_json": yoastHeadJson.toJson(),
// //   "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
// // };
// }
