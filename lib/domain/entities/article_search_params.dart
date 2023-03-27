import 'package:equatable/equatable.dart';

class ArticleSearchParams extends Equatable {
  final String value;

  ArticleSearchParams({required this.value});

  @override
  List<Object> get props => [value];
}
