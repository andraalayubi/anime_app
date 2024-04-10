import 'package:flutter/material.dart';
import '../model/anime.dart'; // Adjust according to your file structure
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
          // Adjust height as needed
          return Container(
            height: 220, // Adjust the height to fit your design
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: animes.length,
              itemBuilder: (context, index) {
                Anime anime = animes[index];
                return Container(
                  width: 140, // Width of each tile
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    elevation: 5, // Shadow effect
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            anime.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            anime.title,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
