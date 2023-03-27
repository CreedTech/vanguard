import 'package:equatable/equatable.dart';

class MovieDetailEntity extends Equatable {
  final int id;
  final DateTime date;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;

  const MovieDetailEntity({
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
  List<Object> get props => [id, date, category, author, title, description, link, banner];
}
