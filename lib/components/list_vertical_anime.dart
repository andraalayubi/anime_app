import 'package:anime_app/pages/detail_anime_page.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart'; // Adjust according to your file structure

class AnimeVerticalList extends StatefulWidget {
  final Future<List<Anime>> Function(int halaman) fetchAnimes;
  final int halaman;

  AnimeVerticalList({required this.fetchAnimes, required this.halaman});

  @override
  _AnimeVerticalListState createState() => _AnimeVerticalListState();
}

class _AnimeVerticalListState extends State<AnimeVerticalList> {
  late Future<List<Anime>> futureAnimes;

  @override
  void initState() {
    super.initState();
    futureAnimes = widget.fetchAnimes(widget.halaman);
  }

  @override
  void didUpdateWidget(covariant AnimeVerticalList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.halaman != widget.halaman) {
      futureAnimes = widget.fetchAnimes(widget.halaman);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<Anime>>(
        future: futureAnimes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Anime> animes = snapshot.data!;
            return ListView.builder(
              itemCount: animes.length,
              itemBuilder: (context, index) {
                Anime anime = animes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnimeDetailPage(id: anime.malId)),
                    );
                  },
                  child: Container(
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
                            height: 140,
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
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Genres: ${anime.genres?.join(', ')}',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[600]),
                                    maxLines: 1,
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Year: ${anime.year.toString()}',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[600]),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Rating: ${anime.ratingStars}',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
      ),
    );
  }
}
