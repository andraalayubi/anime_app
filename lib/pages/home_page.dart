// ignore_for_file: unused_import

import 'package:anime_app/pages/bookmark_page.dart';
import 'package:anime_app/components/list_animes_per_pages.dart';
import 'package:anime_app/components/list_horizontal_anime.dart';
import 'package:anime_app/pages/search_page.dart';
import 'package:anime_app/model/anime.dart';
import 'package:anime_app/utils/service_preferences.dart';
import 'package:anime_app/utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        title: Text('AndraNime'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              final provider =
                  Provider.of<PreferencesService>(context, listen: false);
              provider.updateTheme(!provider.isDarkTheme);
            },
            tooltip: 'Toggle Theme',
          ),
        ],
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
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildCarousel(String title, Future<List<Anime>> Function() fetchAnimes,
      final Future<List<Anime>> Function(int halaman) fetchAnimes2) {
    void onAnimeListReady(bool ready) {
      setState(() {});
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:
                      Theme.of(context).colorScheme.onBackground, // For title
                ),
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.secondary, // For link
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimeHorizontalList(fetch: fetchAnimes, onReady: onAnimeListReady),
      ],
    );
  }
}
