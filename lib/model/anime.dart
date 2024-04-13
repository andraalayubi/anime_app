class Anime {
  final int malId;
  final String imageUrl;
  final String title;
  final List<String>? genres;
  final int? year;
  final double? score;
  final int? episodes;
  final String? status;
  final String? rating;
  final String? synopsis;
  final String? airedFrom;
  final String? airedTo;

  Anime({
    required this.malId,
    required this.imageUrl,
    required this.title,
    this.genres,
    this.year,
    this.score,
    this.episodes,
    this.status,
    this.rating,
    this.synopsis,
    this.airedFrom,
    this.airedTo,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    List<String>? genres = (json['genres'] as List)?.map((genre) => genre['name'].toString()).toList();

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
      airedFrom: json['aired']['form'] ?? '',
      airedTo: json['aired']['to'] ?? '',
    );
  }

  // Metode untuk mengubah skor menjadi bintang dengan penanganan nilai null
  String get ratingStars {
    if (score == null) return '';
    String stars = '';
    int fullStars = score! ~/ 2;  // Menggunakan operator '!' karena score sekarang nullable
    for (int i = 0; i < fullStars; i++) {
      stars += '⭐';
    }
    return stars;
  }
}
