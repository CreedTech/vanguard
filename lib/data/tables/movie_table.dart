import 'package:hive/hive.dart';

import '../../domain/entities/movie_entity.dart';

part 'movie_table.g.dart';

@HiveType(typeId: 0)
class MovieTable extends MovieEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String banner;

  @HiveField(4)
  final String author;

  @HiveField(5)
  final String title;

  @HiveField(6)
  final String description;

  @HiveField(7)
  final String link;

  MovieTable({
    required this.id,
    required this.date,
    required this.category,
    required this.banner,
    required this.author,
    required this.title,
    required this.description,
    required this.link,
  }) : super(
    id: id,
    date: date,
    category: category,
    banner: banner,
    author: author,
    title: title,
    description: description,
    link: link,
  );

  factory MovieTable.fromMovieEntity(MovieEntity movieEntity) {
    return MovieTable(
      id: movieEntity.id,
      date: movieEntity.date,
      category: movieEntity.category,
      banner: movieEntity.banner,
      author: movieEntity.author,
      title: movieEntity.title,
      description: movieEntity.description,
      link: movieEntity.link,
    );
  }
}
