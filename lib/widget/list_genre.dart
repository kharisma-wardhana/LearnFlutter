import 'package:belajar_flutter/bloc/get_movie_genre_bloc.dart';
import 'package:belajar_flutter/widget/genre_movies.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/model/genre.dart';
import 'package:belajar_flutter/style/theme.dart' as Style;

class ListGenre extends StatefulWidget {
  final List<Genre> genres;
  ListGenre({Key key, @required this.genres}) : super(key: key);

  @override
  _ListGenreState createState() => _ListGenreState(genres);
}

class _ListGenreState extends State<ListGenre>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Genre> genres;
  _ListGenreState(this.genres);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: genres.length);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        movieGenre.drainStream();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      child: DefaultTabController(
          length: genres.length,
          child: Scaffold(
            backgroundColor: Style.Colors.mainColor,
            appBar: PreferredSize(
                child: AppBar(
                  backgroundColor: Style.Colors.mainColor,
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorColor: Style.Colors.secondColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: Style.Colors.titleColor,
                    labelColor: Style.Colors.fontColor,
                    isScrollable: true,
                    tabs: genres.map((Genre genre) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          genre.name.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                preferredSize: Size.fromHeight(50)),
            body: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: genres.map((Genre genre) {
                return GenreMovies(genreId: genre.id);
              }).toList(),
            ),
          )),
    );
  }
}
