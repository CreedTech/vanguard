import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../networks/network_dio.dart';
import '../core/api_client.dart';
import '../models/cast_crew_result_data_model.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';
import '../models/movies_result_model.dart';
import '../models/video_model.dart';
import '../models/video_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getComingSoon();
  Future<List<MovieModel>> getSearchedMovies(String searchTerm);
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoModel>> getVideos(int id);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final NetworkContainer http;
  final ApiClient _client;

  MovieRemoteDataSourceImpl(
      this._client,
      {required this.http,});

  @override
  Future<List<MovieModel>> getTrending() async {

    // final response = await _client.get('posts?_embed');
    // print(response);
    // var convertDataToJson = json.decode(response.body);
    // print(convertDataToJson);
    // for (Map<String, dynamic> i in convertDataToJson) {
    //   articles.add(MovieModel.fromJson(i));
    //   print(i.toString());
    // }
    // return articles;
    // if (response.statusCode == 200) {
    //   for (Map<String, dynamic> i in response.data) {
    //     articles.add(MovieModel.fromJson(i));
    //     // print(i.toString());
    //   }
    //   // print(articles);
    //   return articles;
    //   // print(response.data);
    //   // return ArticleModel.fromJson(response.data);
    // }
    // else {
    //   if (kDebugMode) {
    //     print(response);
    //   }
    //   throw response;
    // }
    // final movies = MoviesResultModel.fromJson(response).movies;
    // return movies;
    final List<MovieModel> articles = [];
    final response = await http.method(
      path: "posts?_embed&per_page=1",
      methodType: MethodType.get,
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in response.data) {
        articles.add(MovieModel.fromJson(i));
        // print(i.toString());
      }
      // print(articles);
      return articles;
      // print(response.data);
      // return ArticleModel.fromJson(response.data);
    } else {
      if (kDebugMode) {
        print(DioError);
      }
      throw DioError;
    }
  }


  @override
  Future<List<MovieModel>> getPopular() async {
    // final response = await _client.get('posts?_embed');
    // final movies = MoviesResultModel.fromJson(response).movies;
    // print(movies);
    // return movies;
    final List<MovieModel> articles = [];
    final response = await http.method(
      path: "posts?_embed",
      methodType: MethodType.get,
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in response.data) {
        articles.add(MovieModel.fromJson(i));
        // print(i.toString());
      }
      // print(articles);
      return articles;
      // print(response.data);
      // return ArticleModel.fromJson(response.data);
    } else {
      if (kDebugMode) {
        print(DioError);
      }
      throw DioError;
    }
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
    // final response = await _client.get('posts?_embed');
    // final movies = MoviesResultModel.fromJson(response).movies;
    // print(movies);
    // return movies;
    final List<MovieModel> articles = [];
    final response = await http.method(
      path: "posts?_embed",
      methodType: MethodType.get,
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in response.data) {
        articles.add(MovieModel.fromJson(i));
        // print(i.toString());
      }
      // print(articles);
      return articles;
      // print(response.data);
      // return ArticleModel.fromJson(response.data);
    } else {
      if (kDebugMode) {
        print(DioError);
      }
      throw DioError;
    }
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    // final response = await _client.get('posts?_embed');
    // final movies = MoviesResultModel.fromJson(response).movies;
    // print(movies);
    // return movies;
    final List<MovieModel> articles = [];
    final response = await http.method(
      path: "posts?_embed",
      methodType: MethodType.get,
    );

    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in response.data) {
        articles.add(MovieModel.fromJson(i));
        // print(i.toString());
      }
      // print(articles);
      return articles;
      // print(response.data);
      // return ArticleModel.fromJson(response.data);
    } else {
      if (kDebugMode) {
        print(DioError);
      }
      throw DioError;
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    if (_isValidMovieDetail(movie)) {
      return movie;
    }
    throw Exception();
  }

  bool _isValidMovieDetail(MovieDetailModel movie) {
    return movie.id != -1 &&
        movie.title.isNotEmpty
        // &&
        // movie.posterPath.isNotEmpty
    ;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final response = await _client.get('movie/$id/credits');
    final cast = CastCrewResultModel.fromJson(response).cast;
    return cast;
  }

  @override
  Future<List<VideoModel>> getVideos(int id) async {
    final response = await _client.get('movie/$id/videos');
    final videos = VideoResultModel.fromJson(response).videos;
    return videos;
  }

  @override
  Future<List<MovieModel>> getSearchedMovies(String searchTerm) async {
    final response = await _client.get('search/movie', params: {
      'query': searchTerm,
    });
    final movies = MoviesResultModel.fromJson(response).movies;
    return movies;
  }
}
