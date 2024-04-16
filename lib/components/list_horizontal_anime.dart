import 'package:anime_app/pages/detail_anime_page.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart'; // Sesuaikan dengan struktur file Anda

class AnimeHorizontalList extends StatefulWidget {
  final Future<List<Anime>> Function() fetch;

  AnimeHorizontalList({required this.fetch});

  @override
  _AnimeHorizontalListState createState() => _AnimeHorizontalListState();
}

class _AnimeHorizontalListState extends State<AnimeHorizontalList> {
  late Future<List<Anime>> futureAnimes;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    futureAnimes = widget.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            FutureBuilder<List<Anime>>(
              future: futureAnimes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Anime> animes = snapshot.data!;
                  return Container(
                    height: 185,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: animes.length,
                      itemBuilder: (context, index) {
                        Anime anime = animes[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AnimeDetailPage(id: anime.malId)),
                            );
                          },
                          child: Container(
                            width: 140,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 17,
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
                          ),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(153, 255, 255, 255),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      _scrollController.animateTo(
                        _scrollController.offset - 200,
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 500),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(153, 255, 255, 255),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      _scrollController.animateTo(
                        _scrollController.offset + 200,
                        curve: Curves.linear,
                        duration: Duration(milliseconds: 500),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
