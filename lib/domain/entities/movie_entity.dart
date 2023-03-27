import 'package:equatable/equatable.dart';

import 'movie_detail_entity.dart';

class MovieEntity extends Equatable {
  final int id;
  final DateTime date;

  // final YoastHeadJson yoastHeadJson;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;

  const MovieEntity({
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

  @override
  List<Object> get props => [id, date,
    // yoastHeadJson,
    category, author, title, description, link, banner];

  @override
  bool get stringify => true;

  factory MovieEntity.fromMovieDetailEntity(
      MovieDetailEntity movieDetailEntity) {
    return MovieEntity(
      id: movieDetailEntity.id,
      date: movieDetailEntity.date,
      category: movieDetailEntity.category,
      title: movieDetailEntity.title,
      author: movieDetailEntity.author,
      description: movieDetailEntity.description,
      link: movieDetailEntity.link,
      banner: movieDetailEntity.banner,
      // categories: movieDetailEntity.categories
    );
  }
}
