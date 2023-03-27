import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final int count;

  // final Categories? categories;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.count,
    // this.categories
    // required this.title, this.source,  this.date, this.author, this.description, this.url, this.img, this.content,
  });

  @override
  List<Object> get props => [id, name, count];

  @override
  bool get stringify => true;

// factory CategoryEntity.fromCategoryDetailEntity(
//     CategoryDetailEntity articleDetailEntity) {
//   return CategoryEntity(
//     id: articleDetailEntity.id,
//     date: articleDetailEntity.date,
//     yoastHeadJson: articleDetailEntity.yoastHeadJson,
//     // categories: articleDetailEntity.categories
//
//   );
// }
}

// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);
