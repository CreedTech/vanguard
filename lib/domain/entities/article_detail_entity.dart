import 'package:equatable/equatable.dart';

class ArticleDetailEntity extends Equatable {
  final int id;
  final DateTime date;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;

  const ArticleDetailEntity({
    required this.id,
    required this.date,
    required this.category,
    required this.title,
    required this.banner,
    required this.author,
    required this.description,
    required this.link,
  });

  @override
  List<Object> get props =>
      [id, date, category, author, title, description, link, banner];
}
