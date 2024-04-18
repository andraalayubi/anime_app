import 'package:anime_app/fetch/search.dart';
import 'package:anime_app/model/anime.dart';
import 'package:flutter/material.dart';
import 'package:anime_app/utils/shared_preferences.dart';

class AnimeDetailPage extends StatefulWidget {
  final int id;

  AnimeDetailPage({required this.id});

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Future<Anime> futureAnimes;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    futureAnimes = animesById(widget.id);
    checkIsBookmarked();
  }

   Future<void> checkIsBookmarked() async {
    bool bookmarked = await SharedPreferencesUtil.isAnimeBookmarked(widget.id);
    setState(() {
      isBookmarked = bookmarked;
    });
  }

  Future<void> toggleBookmark() async {
    if (isBookmarked) {
      await SharedPreferencesUtil.removeBookmark(widget.id);
    } else {
      await SharedPreferencesUtil.addBookmark(widget.id);
    }
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Detail'),
        actions: [
          IconButton(
            onPressed: toggleBookmark,
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Anime>(
        future: futureAnimes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            Anime anime = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 16 / 12,
                    child: Image.network(
                      anime.imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: Offset(1.1, 1.1),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            anime.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              letterSpacing: 0.27,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                anime.genres!.join(', '),
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16,
                                  letterSpacing: 0.27,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    anime.score.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                    ),
                                  ),
                                  Icon(Icons.star,
                                      color: Theme.of(context).colorScheme.error, size: 24),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              if (anime.episodes != null)
                                _getTimeBoxUI(anime.episodes!.toString(), 'Episodes'),
                              if (anime.type != null)
                                _getTimeBoxUI(anime.type!, 'Type'),
                              if (anime.status != null)
                                _getTimeBoxUI(anime.status!, 'Status'),
                              if (anime.year != null)
                                _getTimeBoxUI(anime.year!.toString(), 'Year'),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              anime.synopsis ?? "Synopsis not available",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 14,
                                letterSpacing: 0.27,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          } else {
            return Center(child: Text("No data available"));
          }
        },
      ),
    );
  }

  Widget _getTimeBoxUI(String value, String title) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.27,
                ),
                maxLines: 1,
              ),
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
