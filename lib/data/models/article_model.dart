import 'dart:convert';

import 'package:html/parser.dart';

import '../../domain/entities/article_entity.dart';

List<ArticleModel> modelUserFromJson(String str) => List<ArticleModel>.from(
    json.decode(str).map((x) => ArticleModel.fromJson(x)));

String modelUserToJson(List<ArticleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

class ArticleModel extends ArticleEntity {
  final int id;
  final DateTime date;

  // final YoastHeadJson yoastHeadJson;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;

  ArticleModel({
    required this.id,
    required this.date,
    required this.banner,
    // required this.yoastHeadJson,
    required this.category,
    required this.author,
    required this.description,
    required this.title,
    required this.link,
    // this.img,
    // this.date,
    // this.content,
  }) : super(
          id: id,
          // yoastHeadJson: yoastHeadJson,
          date: date,
          category: category,
          title: title,
          description: description,
          link: link,
          author: author,
          banner: banner,
          // categories: categories,
        );

  ArticleEntity toEntity() => ArticleEntity(
        id: id,
        // yoastHeadJson: yoastHeadJson,
        date: date,
        category: category,
        title: title,
        description: description,
        link: link,
        author: author,
        banner: banner,
      );

  factory ArticleModel.fromJson(Map<dynamic, dynamic> json) => ArticleModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        // yoastHeadJson: YoastHeadJson.fromJson(json["yoast_head_json"]),
        banner: json['_embedded']['wp:featuredmedia'][0]['media_details']
                    ['sizes'] ==
                null
            ? ''
            : json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']
                ['full']['source_url'],
        author: json['yoast_head_json']['author'],
        title: _parseHtmlString(json['title']['rendered']),
        category: _parseHtmlString(json['_embedded']['wp:term'][0]
            .lastWhere((term) => term['taxonomy'] == 'category')['name']),
        description: _parseHtmlString(json['content']['rendered']),
        link: json['link'],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        // "yoast_head_json": yoastHeadJson.toJson(),
        "author": author,
        "title": title,
        "category": category,
        "description": description,
        "link": link,
        "banner": banner,
      };
}
