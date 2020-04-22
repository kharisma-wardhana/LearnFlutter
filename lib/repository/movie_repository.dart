import 'package:belajar_flutter/model/movie_response.dart';
import 'package:dio/dio.dart';

class MovieRepository {
  final String apiKey = "2b75defa27c933d072274d82b4afcaf6";
  static final String baseURL = "https://api.themoviedb.org/3";
  final Dio _dio = Dio();

  var getPopularURL = '$baseURL/movie/top_rated';
  var getPlayingURL = '$baseURL/movie/now_playing';
  var getDiscoverURL = '$baseURL/discover/movie';

  Future<MovieResponse> getPopularMovies() async {
    var params = {"api_key": apiKey, "language": "en_US", "page": 1};
    try {
      Response res = await _dio.get(getPopularURL, queryParameters: params);
      return MovieResponse.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured : $error stacktrace : $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "en_US", "page": 1};
    try {
      Response res = await _dio.get(getPlayingURL, queryParameters: params);
      return MovieResponse.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured : $error stacktrace : $stackTrace");
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getDiscoverMovies() async {
    var params = {"api_key": apiKey, "language": "en_US", "page": 1};
    try {
      Response res = await _dio.get(getDiscoverURL, queryParameters: params);
      return MovieResponse.fromJson(res.data);
    } catch (error, stackTrace) {
      print("Exception occured : $error stacktrace : $stackTrace");
      return MovieResponse.withError("$error");
    }
  }
}
