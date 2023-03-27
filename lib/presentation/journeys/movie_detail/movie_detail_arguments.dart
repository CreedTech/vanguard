import '../../../domain/entities/movie_entity.dart';

class MovieDetailArguments {
  final List<MovieEntity> movie;

  const MovieDetailArguments(this.movie);
}
