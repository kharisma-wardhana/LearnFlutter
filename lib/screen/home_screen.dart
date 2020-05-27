import 'package:belajar_flutter/widget/genre.dart';
import 'package:flutter/material.dart';
import 'package:belajar_flutter/widget/now_playing.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:belajar_flutter/style/theme.dart' as Style;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.Colors.fontColor,
      appBar: AppBar(
        backgroundColor: Style.Colors.secondColor,
        leading: Icon(EvaIcons.menu2Outline, color: Style.Colors.fontColor),
        title: Text("Movies App"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(EvaIcons.searchOutline),
              color: Style.Colors.fontColor,
              onPressed: null)
        ],
      ),
      body: ListView(
        children: <Widget>[NowPlaying(), GenreScreen()],
      ),
    );
  }
}
