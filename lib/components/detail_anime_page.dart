import 'package:anime_app/fetch/search.dart';
import 'package:anime_app/model/anime.dart';
import 'package:flutter/material.dart';

class AnimeDetailPage extends StatefulWidget {
  final int id;

  AnimeDetailPage({required this.id});

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  late Future<List<Anime>> futureAnimes;

  @override
  void initState() {
    super.initState();
    futureAnimes = animesById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Anime>>(
        future: futureAnimes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            List<Anime> animes = snapshot.data!;
            if (animes.isEmpty) {
              return Center(child: Text("No data available"));
            }
            Anime anime = animes.first; // Assume only one anime is fetched
            return Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: Image.network(
                        anime.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 32.0,
                                left: 18,
                                right: 16,
                              ),
                              child: Text(
                                anime.title,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.27,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 8,
                                top: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '\$28.99',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '4.3',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: 22,
                                            letterSpacing: 0.27,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  _getTimeBoxUI('24', 'Episodes'),
                                  _getTimeBoxUI('2hours', 'Duration'),
                                  _getTimeBoxUI('2022-01-01', 'Release Date'),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 8,
                                bottom: 8,
                              ),
                              child: Text(
                                'Lorem ipsum is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14,
                                  letterSpacing: 0.27,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35,
                  right: 35,
                  child: Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    elevation: 10.0,
                    child: Container(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SizedBox(
                    width: AppBar().preferredSize.height,
                    height: AppBar().preferredSize.height,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          AppBar().preferredSize.height,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
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
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
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
                  color: Colors.black,
                ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
