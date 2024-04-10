class Anime {
  final int malId;
  final String imageUrl;
  final String title;
  final List<String>? genres;
  final int? year;  // Perhatikan bahwa ini sekarang bertipe nullable
  final double? score;  // Ini juga nullable

  Anime({
    required this.malId,
    required this.imageUrl,
    required this.title,
    this.genres,
    this.year,
    this.score,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    List<String>? genres = (json['genres'] as List)?.map((genre) => genre['name'].toString()).toList();

    return Anime(
      malId: json['mal_id'],
      imageUrl: json['images']['jpg']['image_url'],
      title: json['title'],
      genres: genres,
      year: json['year'] ?? 0,  // Memberikan nilai default jika null
      score: (json['score'] ?? 0).toDouble(),  // Memberikan nilai default dan memastikan tipe double
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
