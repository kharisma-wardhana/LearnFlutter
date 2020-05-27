import 'package:flutter/material.dart';
import 'package:belajar_flutter/model/genre.dart';
import 'package:belajar_flutter/widget/list_genre.dart';
import 'package:belajar_flutter/bloc/get_genres_bloc.dart';
import 'package:belajar_flutter/model/genre_response.dart';
import 'package:belajar_flutter/style/theme.dart' as Style;

class GenreScreen extends StatefulWidget {
  @override
  _GenreScreenState createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  @override
  void initState() {
    super.initState();
    genreListBloc.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GenreResponse>(
        stream: genreListBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildGenreListWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30.0,
            width: 30.0,
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Style.Colors.secondColor),
              strokeWidth: 3.0,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String err) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text("Error occured $err")],
      ),
    );
  }

  Widget _buildGenreListWidget(GenreResponse data) {
    List<Genre> genres = data.genres;
    if (genres.length == 0) {
      return Container(
        child: Text("No Genre"),
      );
    } else {
      return ListGenre(genres: genres);
    }
  }
}
