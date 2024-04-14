import 'dart:convert';
import 'package:anime_app/fetch/search.dart';
import 'package:anime_app/model/anime.dart';
import 'package:anime_app/utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  late List<int>
      bookmarkedIds; // Daftar ID anime yang ditandai sebagai bookmark
  List<Anime> bookmarkedAnimes =
      []; // Daftar anime yang ditandai sebagai bookmark

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    List<int> ids = await SharedPreferencesUtil.getBookmarkList();
    setState(() {
      bookmarkedIds = ids;
    });
    loadAnimes(); // Pastikan ini dipanggil setelah setState selesai
  }

  Future<void> saveBookmarks() async {
    await SharedPreferencesUtil.setBookmarkList(bookmarkedIds);
  }

  Future<void> loadAnimes() async {
    // Dari daftar ID, muat detail anime untuk setiap ID dan tambahkan ke daftar bookmarkedAnimes
    List<Anime> animes = [];
    print('BookmarkedIds: $bookmarkedIds');
    for (int id in bookmarkedIds) {
      Anime anime = await animesById(id);
      animes.add(anime);
    }
    setState(() {
      bookmarkedAnimes = animes;
      print('BookmarkedAnimes: $bookmarkedAnimes');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: ListView.builder(
        itemCount: bookmarkedAnimes.length,
        itemBuilder: (context, index) {
          Anime anime = bookmarkedAnimes[index];
          return ListTile(
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
          );
        },
      ),
    );
  }
}
