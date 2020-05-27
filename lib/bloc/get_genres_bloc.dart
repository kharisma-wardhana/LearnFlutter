import 'package:belajar_flutter/model/genre_response.dart';
import 'package:belajar_flutter/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

final genreListBloc = GenreListBloc();

class GenreListBloc {
  final MovieRepository _movieRepo = MovieRepository();
  final BehaviorSubject<GenreResponse> _subject =
      BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse _res = await _movieRepo.getGenres();
    _subject.sink.add(_res);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _subject;
}
