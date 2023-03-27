import 'dart:convert';

import 'package:html/parser.dart';

import '../../domain/entities/movie_entity.dart';


List<MovieModel> modelUserFromJson(String str) => List<MovieModel>.from(
    json.decode(str).map((x) => MovieModel.fromJson(x)));

String modelUserToJson(List<MovieModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}

class MovieModel extends MovieEntity {
  final int id;
  final DateTime date;

  // final YoastHeadJson yoastHeadJson;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;

  MovieModel({
    required this.id,
    required this.date,
    required this.banner,
    // required this.yoastHeadJson,
    required this.category,
    required this.author,
    required this.description,
    required this.title,
    required this.link,
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
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
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
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['video'] = this.video;
  //   data['vote_count'] = this.voteCount;
  //   data['vote_average'] = this.voteAverage;
  //   data['title'] = this.title;
  //   data['release_date'] = this.releaseDate;
  //   data['original_language'] = this.originalLanguage;
  //   data['original_title'] = this.originalTitle;
  //   data['genre_ids'] = this.genreIds;
  //   data['backdrop_path'] = this.backdropPath;
  //   data['adult'] = this.adult;
  //   data['overview'] = this.overview;
  //   data['poster_path'] = this.posterPath;
  //   data['popularity'] = this.popularity;
  //   data['media_type'] = this.mediaType;
  //   return data;
  // }


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
