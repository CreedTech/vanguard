import '../../domain/entities/movie_detail_entity.dart';
import 'package:html/parser.dart';

String _parseHtmlString(String htmlString) {
  var document = parse(htmlString);

  String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}


class MovieDetailModel extends MovieDetailEntity {
  final int id;
  final DateTime date;
  final String category;
  final String banner;
  final String author;
  final String title;
  final String description;
  final String link;

  MovieDetailModel(
      {required this.id,
        required this.date,
        required this.banner,
        required this.category,
        required this.author,
        required this.description,
        required this.title,
        required this.link,})
      : super(
    id: id,
    date: date,
    category: category,
    title: title,
    description: description,
    link: link,
    author: author,
    banner: banner,
        );

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['adult'] = this.adult;
  //   data['backdrop_path'] = this.backdropPath;
  //   if (this.belongsToCollection != null) {
  //     data['belongs_to_collection'] = this.belongsToCollection?.toJson();
  //   }
  //   data['budget'] = this.budget;
  //   if (this.genres != null) {
  //     data['genres'] = this.genres?.map((v) => v?.toJson()).toList();
  //   }
  //   data['homepage'] = this.homepage;
  //   data['id'] = this.id;
  //   data['imdb_id'] = this.imdbId;
  //   data['original_language'] = this.originalLanguage;
  //   data['original_title'] = this.originalTitle;
  //   data['overview'] = this.overview;
  //   data['popularity'] = this.popularity;
  //   data['poster_path'] = this.posterPath;
  //   if (this.productionCompanies != null) {
  //     data['production_companies'] =
  //         this.productionCompanies?.map((v) => v?.toJson()).toList();
  //   }
  //   if (this.productionCountries != null) {
  //     data['production_countries'] =
  //         this.productionCountries?.map((v) => v?.toJson()).toList();
  //   }
  //   data['release_date'] = this.releaseDate;
  //   data['revenue'] = this.revenue;
  //   data['runtime'] = this.runtime;
  //   if (this.spokenLanguages != null) {
  //     data['spoken_languages'] =
  //         this.spokenLanguages?.map((v) => v?.toJson()).toList();
  //   }
  //   data['status'] = this.status;
  //   data['tagline'] = this.tagline;
  //   data['title'] = this.title;
  //   data['video'] = this.video;
  //   data['vote_average'] = this.voteAverage;
  //   data['vote_count'] = this.voteCount;
  //   return data;
  // }

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

_genres(Map<String, dynamic> json) {
  if (json['genres'] != null) {
    final genres = List<Genres>.empty(growable: true);
    json['genres'].forEach((v) {
      genres.add(new Genres.fromJson(v));
    });
  }
}

class BelongsToCollection {
  late int? id;
  late String? name;
  late String? posterPath;
  late String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    return data;
  }
}

class Genres {
  late int? id;
  late String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ProductionCompanies {
  late int? id;
  late String? logoPath;
  late String? name;
  late String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo_path'] = this.logoPath;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class ProductionCountries {
  late String? iso31661;
  late String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}

class SpokenLanguages {
  late String? iso6391;
  late String? name;

  SpokenLanguages({this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_639_1'] = this.iso6391;
    data['name'] = this.name;
    return data;
  }
}
