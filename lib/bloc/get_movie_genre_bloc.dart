import 'package:belajar_flutter/model/movie_response.dart';
import 'package:belajar_flutter/repository/movie_repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

final movieGenre = MovieGenreBloc();

class MovieGenreBloc {
  final MovieRepository _movieRepo = MovieRepository();
  final BehaviorSubject<MovieResponse> _subject =
      BehaviorSubject<MovieResponse>();

  getMovieByGenre(int id) async {
    MovieResponse _res = await _movieRepo.getMovieByGenre(id);
    _subject.sink.add(_res);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}
