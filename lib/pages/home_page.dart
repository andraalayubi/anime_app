import 'package:anime_app/pages/bookmark_page.dart';
import 'package:anime_app/components/list_animes_per_pages.dart';
import 'package:anime_app/components/list_horizontal_anime.dart';
import 'package:anime_app/pages/search_page.dart';
import 'package:anime_app/model/anime.dart';
import 'package:anime_app/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../fetch/fetch.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookmarkPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'AndraNime',
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          buildCarousel('Most Popular', fetch8Popular, fetchAllPopular),
          buildCarousel(
              'Available Now', fetch8AvailableNow, fetchAllAvailableNow),
          buildCarousel('Coming Soon', fetch8ComingSoon, fetchAllComingSoon),
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

  Widget buildCarousel(String title, Future<List<Anime>> Function() fetchAnimes,
      final Future<List<Anime>> Function(int halaman) fetchAnimes2) {
    bool isAnimeListReady = false;

    void onAnimeListReady(bool ready) {
      setState(() {
        isAnimeListReady = ready;
      });
    }

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
                        builder: (context) => ListAnimesPerPages(
                            fetch: fetchAnimes2, title: title)),
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
        AnimeHorizontalList(fetch: fetchAnimes, onReady: onAnimeListReady),
        isAnimeListReady ? Text("Anime List is ready!") : Container(),
      ],
    );
  }
}
