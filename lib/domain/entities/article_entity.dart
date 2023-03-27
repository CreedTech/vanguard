import 'package:equatable/equatable.dart';

import '../../data/models/article_model.dart';
import 'article_detail_entity.dart';

class ArticleEntity extends Equatable {
  final int id;
  final DateTime date;

  // final YoastHeadJson yoastHeadJson;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;

  // final Categories? categories;

  const ArticleEntity({
    required this.id,
    required this.date,
    // required this.yoastHeadJson,
    required this.category,
    required this.title,
    required this.banner,
    // this.source,  this.date,
    required this.author,
    required this.description,
    required this.link,
    // this.img, this.content,
  });

  ArticleModel toModel() => ArticleModel(
        id: id,
        date: date,
        // yoastHeadJson: yoastHeadJson.toModel(),
        category: category,
        author: author,
        title: title,
        description: description,
        link: link,
        banner: banner,
      );

  @override
  List<Object> get props => [
        id, date,
        // yoastHeadJson,
        category, author, title, description, link, banner
      ];

  @override
  bool get stringify => true;

  factory ArticleEntity.fromArticleDetailEntity(
      ArticleDetailEntity articleDetailEntity) {
    return ArticleEntity(
      id: articleDetailEntity.id,
      date: articleDetailEntity.date,
      category: articleDetailEntity.category,
      title: articleDetailEntity.title,
      author: articleDetailEntity.author,
      description: articleDetailEntity.description,
      link: articleDetailEntity.link,
      banner: articleDetailEntity.banner,
      // categories: articleDetailEntity.categories
    );
  }
}

// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);
