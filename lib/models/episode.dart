class Episode {
  final int id;
  final String airDate;
  final int episodeNumber;
  final String imagePath;
  final String name;
  final int season;
  final String synopsis;

  Episode({
    required this.id,
    required this.airDate,
    required this.episodeNumber,
    required this.imagePath,
    required this.name,
    required this.season,
    required this.synopsis,
  });
  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      airDate: json['airdate'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      imagePath: json['image_path'] ?? '',
      name: json['name'] ?? '',
      season: json['season'] ?? 0,
      synopsis: json['synopsis'] ?? '',
    );
  }

  // La API devuelve una ruta relativa, así que construimos la URL completa aquí
  String get imageUrl => "https://cdn.thesimpsonsapi.com/500$imagePath";
}
