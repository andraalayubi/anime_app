import 'package:flutter/material.dart';
import '../model/anime.dart'; // Pastikan lokasi ini sesuai dengan lokasi file model Anime kamu
import '../fetch/populer.dart';

class CustomAnimeList extends StatefulWidget {
  @override
  _CustomAnimeListState createState() => _CustomAnimeListState();
}

class _CustomAnimeListState extends State<CustomAnimeList> {
  late Future<List<Anime>> futureAnimes;

  @override
  void initState() {
    super.initState();
    futureAnimes = fetchAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Anime>>(
      future: futureAnimes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Anime> animes = snapshot.data!;
          return ListView.builder(
            itemCount: animes.length,
            itemBuilder: (context, index) {
              Anime anime = animes[index];
              return Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      anime.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anime.title,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Genres: ${anime.genres?.join(', ')}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            'Year: ${anime.year?.toString() ?? 'N/A'}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            'Rating: ${anime.ratingStars}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        // Menampilkan loading spinner sampai data siap
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
