import 'package:equatable/equatable.dart';

class ArticlePageParams extends Equatable {
  final int page;

  const ArticlePageParams(this.page);

  @override
  List<Object> get props => [page];
}
