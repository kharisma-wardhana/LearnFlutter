import 'package:flutter/material.dart';
import 'package:belajar_flutter/model/movie.dart';
import 'package:belajar_flutter/style/theme.dart' as Style;
import 'package:belajar_flutter/bloc/get_playing_movies_bloc.dart';
import 'package:belajar_flutter/model/movie_response.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
    nowPlayingBloc.getPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
        stream: nowPlayingBloc.subject.stream,
        builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return _buildErrorWidget(snapshot.data.error);
            }
            return _buildNowPlayingWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget _buildLoadingWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Style.Colors.titleColor,
      height: 220,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Style.Colors.mainColor),
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

  Widget _buildNowPlayingWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text("No Movies")],
        ),
      );
    } else {
      return Container(
        height: 220,
        child: PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            indicatorSpace: 8.0,
            padding: EdgeInsets.all(5.0),
            indicatorColor: Style.Colors.mainColor,
            indicatorSelectorColor: Style.Colors.secondColorDark,
            shape: IndicatorShape.circle(size: 10.0),
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.take(5).length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${movies[index].backdrop}"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xFF5892D4),
                                Color(0xFF141E30).withOpacity(0.2),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0, 0.9]),
                        ),
                      ),
                      Positioned(
                          bottom: 30.0,
                          child: Container(
                            padding: EdgeInsets.only(left: 1.0, right: 1.0),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Text(movies[index].title,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            height: 1.5,
                                            wordSpacing: 1.2,
                                            color: Style.Colors.mainColorDark,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0)))
                              ],
                            ),
                          ))
                    ],
                  );
                }),
            length: movies.take(5).length),
      );
    }
  }
}
