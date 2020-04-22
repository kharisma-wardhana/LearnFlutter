class Movie {
  final int id;
  final String poster;
  final String backdrop;
  final String title;
  final String overview;
  final double rating;
  final double popularity;

  Movie(this.id, this.poster, this.backdrop, this.title, this.overview,
      this.rating, this.popularity);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        poster = json["poster_path"],
        backdrop = json["backdrop_path"],
        title = json["title"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble(),
        popularity = json["popularity"];
}
