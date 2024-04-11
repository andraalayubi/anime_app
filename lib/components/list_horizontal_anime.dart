import 'package:anime_app/components/search_page.dart';
import 'package:anime_app/fitness_app/bottom_navigation_view/bottom_bar_view.dart';
import 'package:anime_app/fitness_app/models/tabIcon_data.dart';
import 'package:anime_app/fitness_app/my_diary/my_diary_screen.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart';
import '../fetch/populer.dart';
import 'package:anime_app/components/list_vertical_anime.dart';

class AnimeHorizontalList extends StatefulWidget {
  @override
  _AnimeHorizontalListState createState() => _AnimeHorizontalListState();
}

class _AnimeHorizontalListState extends State<AnimeHorizontalList> {
  late Future<List<Anime>> futureAnimes;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    futureAnimes = fetch8Animes();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      } else if (index == 2) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => BookmarkPage()),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Most Popular',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomAnimeList()),
                    );
                  },
                  child: Text(
                    'See more',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<List<Anime>>(
            future: futureAnimes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Anime> animes = snapshot.data!;
                return Container(
                  height: MediaQuery.of(context).size.height *
                      0.3, // Adjust the height to fit your design
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
                            borderRadius:
                                BorderRadius.circular(10), // Rounded corners
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
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
