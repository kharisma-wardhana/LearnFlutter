import 'package:belajar_flutter/model/movie_response.dart';
import 'package:belajar_flutter/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

final movieBloc = MovieListBloc();

class MovieListBloc {
  final MovieRepository _movieRepo = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getPopularMovies() async {
    MovieResponse _res = await _movieRepo.getPopularMovies();
    _subject.sink.add(_res);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}
