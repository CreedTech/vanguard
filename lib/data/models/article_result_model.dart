import 'article_model.dart';

class ArticleResultModel {
  final List<ArticleModel> articles;

  ArticleResultModel({required this.articles});

  ArticleResultModel.fromJson(Map<dynamic, dynamic> json)
      : articles = (json["articles"] as List)
            .map((i) => ArticleModel.fromJson(i))
            .toList();

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['articles'] = articles.map((v) => v.toJson()).toList();
    return data;
  }
}
