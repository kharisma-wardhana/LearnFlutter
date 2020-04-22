import 'package:belajar_flutter/model/movie.dart';

class MovieResponse {
  final List<Movie> movies;
  final String error;
  final int page;
  final int totalPages;
  final int totalResults;

  MovieResponse(
      this.movies, this.error, this.page, this.totalPages, this.totalResults);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((i) => new Movie.fromJson(i))
            .toList(),
        page = json["page"],
        totalPages = json["total_pages"],
        totalResults = json["total_results"],
        error = "";

  MovieResponse.withError(String errorValue)
      : movies = List(),
        page = 0,
        totalPages = 0,
        totalResults = 0,
        error = errorValue;
}
