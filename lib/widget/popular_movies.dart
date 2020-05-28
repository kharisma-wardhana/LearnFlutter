import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/bloc/get_popular_movies_bloc.dart';
import 'package:belajar_flutter/model/movie.dart';
import 'package:belajar_flutter/model/movie_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:belajar_flutter/style/theme.dart' as Style;

class PopularMovies extends StatefulWidget {
  @override
  _PopularMoviesState createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  @override
  void initState() {
    super.initState();
    movieBloc.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
        stream: movieBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildPopularListWidget(snapshot.data);
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

  Widget _buildPopularListWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    Size size = MediaQuery.of(context).size;
    if (movies.length == 0) {
      return Container(
        child: Text("No Movies"),
      );
    } else {
      return Container(
          padding: EdgeInsets.only(left: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Popular Movies',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Style.Colors.secondColor))),
                Container(
                  height: size.height * 0.8,
                  child: GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2),
                    scrollDirection: Axis.vertical,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Column(children: <Widget>[
                        movies[index].poster == null
                            ? Expanded(
                                child: Container(
                                  width: size.width * 0.35,
                                  height: size.height * 0.5,
                                  margin: EdgeInsets.only(left: 5, bottom: 5),
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
                                ),
                              )
                            : Expanded(
                                child: Container(
                                  width: size.width * 0.35,
                                  height: size.height * 0.5,
                                  margin: EdgeInsets.only(left: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500${movies[index].poster}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                      ]);
                    },
                  ),
                )
              ]));
    }
  }
}
