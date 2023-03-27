import 'dart:convert';

import '../../domain/entities/category_entity.dart';

List<CategoryModel> modelUserFromJson(String str) => List<CategoryModel>.from(
    json.decode(str).map((x) => CategoryModel.fromJson(x)));

String modelUserToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel extends CategoryEntity {
  final int id;
  final String name;
  final int count;

  CategoryModel({
    required this.id,
    required this.name,
    required this.count,
  }) : super(
          id: id,
          name: name,
          count: count,
        );

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        count: json["count"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "count": count,
      };
}
