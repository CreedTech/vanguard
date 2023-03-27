// import 'package:equatable/equatable.dart';
//
//
// class NewsEntities extends Equatable {
//   final String status;
//   final int total;
//   final List<ArticleEntity> articles;
//
//   const NewsEntities({
//     required this.status,
//     required this.total,
//     required this.articles,
//   });
//
//   NewsModel toModel() => NewsModel(
//         status: status,
//         total: total,
//         articles: articles.map((e) => e.toModel()).toList(),
//       );
//
//   @override
//   List<Object> get props => [status, total, articles];
// }
//
// // class ArticleEntity extends Equatable {
// //   final NewsArticleSourceEntities source;
// //   final int id;
// //   final DateTime date;
// //   const ArticleEntity({
// //     required this.source,
// //     required this.id,
// //     required this.date,
// //   });
// //
// //   NewsArticleModel toModel() => NewsArticleModel(
// //         source: source.toModel(),
// //         id: id,
// //         date: date,
// //       );
// //
// //   @override
// //   List<Object> get props {
// //     return [source, id, date];
// //   }
// // }
// //
// // class NewsArticleSourceEntities extends Equatable {
// //   final String title;
// //   final String ogDescription;
// //   final String ogUrl;
// //   final String author;
// //   // final List<NewsArticleImageEntities> ogImage;
// //   // final NewsArticleSchemaEntities schema;
// //   // final Schema? schema;
// //   const NewsArticleSourceEntities(
// //       {required this.title,
// //       required this.ogDescription,
// //       required this.ogUrl,
// //       required this.author,
// //       // required this.ogImage,
// //       // required this.schema
// //       });
// //
// //   NewsArticleSourceModel toModel() => NewsArticleSourceModel(
// //       title: title,
// //       ogDescription: ogDescription,
// //       ogUrl: ogUrl,
// //       author: author,
// //       // ogImage: ogImage.map((e) => e.toModel()).toList(),
// //       // schema: schema.toModel()
// //   );
// //   @override
// //   List<Object> get props =>
// //       [title, ogDescription, ogUrl, author,
// //         // ogImage, schema
// //       ];
// // }
// // //
// // // class NewsArticleImageEntities extends Equatable {
// // //   final String url;
// // //   const NewsArticleImageEntities({required this.url});
// // //
// // //   NewsArticleImageModel toModel() => NewsArticleImageModel(
// // //         url: url,
// // //       );
// // //   @override
// // //   List<Object> get props => [url];
// // // }
// // //
// // // class NewsArticleSchemaEntities extends Equatable {
// // //   final List<NewsArticleSchemaGraphEntities> graph;
// // //   const NewsArticleSchemaEntities({
// // //     required this.graph,
// // //   });
// // //
// // //   NewsArticleSchemaModel toModel() => NewsArticleSchemaModel(
// // //         graph: graph.map((e) => e.toModel()).toList(),
// // //       );
// // //   @override
// // //   List<Object> get props => [graph];
// // // }
// // //
// // // class NewsArticleSchemaGraphEntities extends Equatable {
// // //   final List<String> articleSection;
// // //   const NewsArticleSchemaGraphEntities({
// // //     required this.articleSection,
// // //   });
// // //
// // //   NewsArticleSchemaGraphModel toModel() => NewsArticleSchemaGraphModel(
// // //         articleSection: articleSection.map((e) => e).toList(),
// // //       );
// // //   @override
// // //   List<Object> get props => [articleSection];
// // // }
