

class Genre {
  final int id;
  final String name;
  Genre({required this.id, required this.name});
  factory Genre.fromJson(Map<String, dynamic> j) =>
      Genre(id: j['id'] as int, name: j['name'] as String);
}
