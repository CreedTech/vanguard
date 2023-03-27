import 'package:equatable/equatable.dart';

class ArticleSourceNewsParams extends Equatable {
  final String sourceId;

  ArticleSourceNewsParams({required this.sourceId});

  @override
  List<Object> get props => [sourceId];
}
