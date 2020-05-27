class Person {
  final int id;
  final String profileImg;
  final String name;
  final String known;
  final double popularity;

  Person(this.id, this.profileImg, this.name, this.known, this.popularity);

  Person.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        profileImg = json["profile_path"],
        name = json["name"],
        known = json["known_for_department"],
        popularity = json["popularity"];
}
