import 'package:anime_app/components/list_horizontal_anime.dart';
import 'package:anime_app/components/search_page.dart';
import 'package:anime_app/model/anime.dart';
import 'package:flutter/material.dart';
import '../fetch/populer.dart';
import 'package:anime_app/components/list_vertical_anime copy.dart';

class Most8Populer extends StatefulWidget {
  @override
  _Most8PopulerState createState() => _Most8PopulerState();
}

class _Most8PopulerState extends State<Most8Populer> {
  int _selectedIndex = 0;

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
      body: ListView(
        children: [
          buildCarousel('Most Popular', fetch8Animes),
          buildCarousel('Available Now', fetch8AvailableNow),
          buildCarousel('Coming Soon', fetch8ComingSoon),
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

  Widget buildCarousel(String title, Future<List<Anime>> Function() fetchAnimes) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListAnimePopuler()),
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
        AnimeHorizontalList(fetch: fetchAnimes)
      ],
    );
  }
}
