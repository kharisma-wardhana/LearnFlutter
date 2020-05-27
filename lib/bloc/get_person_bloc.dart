import 'package:belajar_flutter/model/person_response.dart';
import 'package:belajar_flutter/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

final personListBloc = PersonListBloc();

class PersonListBloc {
  final MovieRepository _movieRepo = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse _res = await _movieRepo.getPersons();
    _subject.sink.add(_res);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}
