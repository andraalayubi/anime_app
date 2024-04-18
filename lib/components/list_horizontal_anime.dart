import 'package:anime_app/pages/detail_anime_page.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart';

class AnimeHorizontalList extends StatefulWidget {
  final Future<List<Anime>> Function() fetch;
  final Function onReady;

  AnimeHorizontalList({required this.fetch, required this.onReady});

  @override
  _AnimeHorizontalListState createState() => _AnimeHorizontalListState();
}

class _AnimeHorizontalListState extends State<AnimeHorizontalList> {
  late Future<List<Anime>> futureAnimes;
  final ScrollController _scrollController = ScrollController();
  bool isReady = true;

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
                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error, // Error color
                      ),
                    ));
                  } else if (snapshot.hasData) {
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
                                    borderRadius: BorderRadius.circular(10)),
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
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).colorScheme.onSurface, // Text color
                                        ),
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
                  } else {
                    return Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.secondary, // Progress indicator color
                      ),
                    ));
                  }
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.background.withAlpha(153), // Button background
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Theme.of(context).colorScheme.onBackground, // Icon color
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
                    color: Theme.of(context).colorScheme.background.withAlpha(153), // Button background
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    color: Theme.of(context).colorScheme.onBackground, // Icon color
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
