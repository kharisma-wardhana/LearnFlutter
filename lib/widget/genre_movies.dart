import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/bloc/get_movie_genre_bloc.dart';
import 'package:belajar_flutter/model/movie_response.dart';
import 'package:belajar_flutter/model/movie.dart';
import 'package:belajar_flutter/style/theme.dart' as Style;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class GenreMovies extends StatefulWidget {
  final int genreId;

  GenreMovies({Key key, this.genreId}) : super(key: key);

  @override
  _GenreMoviesState createState() => _GenreMoviesState(genreId);
}

class _GenreMoviesState extends State<GenreMovies> {
  final int genreId;

  _GenreMoviesState(this.genreId);

  @override
  void initState() {
    super.initState();
    movieGenre.getMovieByGenre(genreId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
        stream: movieGenre.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildMovieGenreWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Center(
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

  Widget _buildMovieGenreWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    Size size = MediaQuery.of(context).size;
    if (movies.length == 0) {
      return Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text("No Movies")],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 5, right: 5, top: 5),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  movies[index].poster == null
                      ? Container(
                          width: 110,
                          height: size.height * 0.25,
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Style.Colors.secondColor,
                              shape: BoxShape.rectangle),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                EvaIcons.filmOutline,
                                color: Style.Colors.mainColor,
                                size: 50,
                              )
                            ],
                          ),
                        )
                      : Container(
                          width: 110,
                          height: size.height * 0.25,
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${movies[index].poster}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    width: 90,
                    child: Center(
                      child: Text(
                        movies[index].title,
                        maxLines: 1,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                height: 1.4,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Style.Colors.secondColor)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        movies[index].rating.toString(),
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Style.Colors.secondColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      RatingBar(
                        itemSize: 8,
                        initialRating: movies[index].rating / 2,
                        minRating: 1,
                        glow: true,
                        glowColor: Style.Colors.mainColorDark,
                        allowHalfRating: true,
                        unratedColor: Style.Colors.mainColor,
                        onRatingUpdate: (double rating) {
                          print(rating);
                        },
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          EvaIcons.star,
                          color: Style.Colors.secondColorDark,
                        ),
                      )
                    ],
                  ),
                ],
              );
            }),
      );
    }
  }
}
