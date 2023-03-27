import 'package:equatable/equatable.dart';

class ArticleParams extends Equatable {
  final int id;

  const ArticleParams(this.id);

  @override
  List<Object> get props => [id];
}
