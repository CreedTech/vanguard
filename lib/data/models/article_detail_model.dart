import 'package:html/parser.dart';

import '../../domain/entities/article_detail_entity.dart';

String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

class ArticleDetailModel extends ArticleDetailEntity {
  final int id;
  final DateTime date;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;

  ArticleDetailModel({
    required this.id,
    required this.date,
    required this.banner,
    required this.category,
    required this.author,
    required this.description,
    required this.title,
    required this.link,
  }) : super(
          id: id,
          date: date,
          category: category,
          title: title,
          description: description,
          link: link,
          author: author,
          banner: banner,
        );

  factory ArticleDetailModel.fromJson(Map<dynamic, dynamic> json) {
    return ArticleDetailModel(
      id: json["id"],
      date: DateTime.parse(json["date"]),
      banner: json['_embedded']['wp:featuredmedia'][0]['media_details']
                  ['sizes'] ==
              null
          ? ''
          : json['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']
              ['full']['source_url'],
      author: json['yoast_head_json']['author'],
      title: _parseHtmlString(json['title']['rendered']),
      category: json['_embedded']['wp:term'][0]
          .lastWhere((term) => term['taxonomy'] == 'category')['name'],
      description: _parseHtmlString(json['content']['rendered']),
      link: json['link'],
    );
  }

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "author": author,
        "title": title,
        "category": category,
        "description": description,
        "link": link,
        "banner": banner,
      };
}
