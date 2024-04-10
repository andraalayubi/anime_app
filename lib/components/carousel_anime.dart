import 'package:flutter/material.dart';
import '../model/anime.dart'; // Adjust the path as needed
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
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        anime.imageUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            anime.title,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Genres: ${anime.genres?.join(', ')}',
                            style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Year: ${anime.year?.toString() ?? 'N/A'}',
                            style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Rating: ${anime.ratingStars}',
                            style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
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
        // Displaying a loading spinner until the data is ready
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
