import 'package:anime_app/pages/detail_anime_page.dart';
import 'package:anime_app/pages/home_page.dart';
import 'package:anime_app/pages/search_page.dart';
import 'package:anime_app/fetch/search.dart';
import 'package:anime_app/model/anime.dart';
import 'package:anime_app/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late List<int> bookmarkedIds;
  List<Anime> bookmarkedAnimes = [];
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );
      }
    });
  }

  Future<void> loadBookmarks() async {
    List<int> ids = await SharedPreferencesUtil.getBookmarkList();
    setState(() {
      bookmarkedIds = ids;
    });
    loadAnimes();
  }

  Future<void> saveBookmarks() async {
    await SharedPreferencesUtil.setBookmarkList(bookmarkedIds);
  }

  Future<void> loadAnimes() async {
    List<Anime> animes = [];
    for (int id in bookmarkedIds) {
      Anime anime = await animesById(id);
      animes.add(anime);
    }
    setState(() {
      bookmarkedAnimes = animes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bookmarks',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: bookmarkedAnimes.length,
        itemBuilder: (context, index) {
          Anime anime = bookmarkedAnimes[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimeDetailPage(id: anime.malId),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(anime.imageUrl),
              ),
              title: Text(anime.title),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  setState(() {
                    // Hapus anime dari daftar bookmarkedAnimes
                    bookmarkedAnimes.removeAt(index);
                    // Hapus ID anime dari daftar bookmarkedIds
                    bookmarkedIds.removeAt(index);
                    // Simpan perubahan daftar bookmark
                    saveBookmarks();
                  });
                },
              ),
            ),
          );
        },
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
}
