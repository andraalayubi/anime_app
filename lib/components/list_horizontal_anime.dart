import 'package:flutter/material.dart';
import '../model/anime.dart'; // Pastikan ini sesuai dengan lokasi file model Anime kamu
import '../fetch/populer.dart';

class AnimeHorizontalList extends StatefulWidget {
  @override
  _AnimeHorizontalListState createState() => _AnimeHorizontalListState();
}

class _AnimeHorizontalListState extends State<AnimeHorizontalList> {
  late Future<List<Anime>> futureAnimes;

  @override
  void initState() {
    super.initState();
    futureAnimes = fetch8Animes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Anime>>(
      future: futureAnimes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Anime> animes = snapshot.data!;
          return Container(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: animes.length,
              itemBuilder: (context, index) {
                Anime anime = animes[index];
                return Container(
                  width: 140, // Lebar setiap item
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          anime.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        anime.title,
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(4),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
