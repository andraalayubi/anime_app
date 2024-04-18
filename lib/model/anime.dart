class Anime {
  final int malId;
  final String imageUrl;
  final String title;
  final List<String>? genres;
  final int? year;
  final double? score;
  final int? episodes;
  final String? type;
  final String? status;
  final String? rating;
  final String? synopsis;

  Anime(
      {required this.malId,
      required this.imageUrl,
      required this.title,
      this.genres,
      this.year,
      this.score,
      this.episodes,
      this.status,
      this.rating,
      this.synopsis,
      this.type});

  factory Anime.fromJson(Map<String, dynamic> json) {
    List<String>? genres = (json['genres'] as List)
        ?.map((genre) => genre['name'].toString())
        .toList();

    return Anime(
      malId: json['mal_id'],
      imageUrl: json['images']['jpg']['image_url'],
      title: json['title'],
      genres: genres,
      year: json['year'] ?? 0,
      score: (json['score'] ?? 0).toDouble(),
      episodes: json['episodes'] ?? 0,
      status: json['status'] ?? '',
      rating: json['rating'] ?? '',
      synopsis: json['synopsis'] ?? '',
      type: json['type'] ?? '',
    );
  }

  // Metode untuk mengubah skor menjadi bintang dengan penanganan nilai null
  String get ratingStars {
    if (score == null) return '';

    String scoreString = score!.toStringAsFixed(1);
    double scoreValue = double.parse(scoreString);
    int fullStars = (scoreValue / 2).round();

    String stars = '';
    for (int i = 0; i < fullStars; i++) {
      stars += '⭐';
    }

    return stars;
  }
}
