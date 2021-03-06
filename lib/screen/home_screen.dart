import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:belajar_flutter/widget/now_playing.dart';
import 'package:belajar_flutter/widget/genre.dart';
import 'package:belajar_flutter/widget/popular_movies.dart';
import 'package:belajar_flutter/style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Style.Colors.mainColor,
        appBar: AppBar(
          backgroundColor: Style.Colors.mainColor,
          leading: IconButton(
            icon: Icon(
              EvaIcons.menu2Outline,
              color: Style.Colors.fontColor,
            ),
            onPressed: null,
          ),
          title: Text("Movies App",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.bold))),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon:
                    Icon(EvaIcons.searchOutline, color: Style.Colors.fontColor),
                onPressed: null)
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Color(0xFF5892D4),
                Color(0xFF141E30),
              ])),
          child: ListView(
            children: <Widget>[NowPlaying(), GenreScreen(), PopularMovies()],
          ),
        ),
      ),
    );
  }
}
