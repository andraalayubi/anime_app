import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static const String _bookmarkKey = 'bookmark';

  static Future<void> addBookmark(int animeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> bookmarkList = prefs.containsKey(_bookmarkKey)
        ? List<int>.from(jsonDecode(prefs.getString(_bookmarkKey) ?? '[]'))
        : [];
    bookmarkList.add(animeId);
    await prefs.setString(_bookmarkKey, jsonEncode(bookmarkList));
    print('Bookmark added for animeId: $animeId');
  }

  static Future<void> removeBookmark(int animeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> bookmarkList = prefs.containsKey(_bookmarkKey)
        ? List<int>.from(jsonDecode(prefs.getString(_bookmarkKey) ?? '[]'))
        : [];
    bookmarkList.remove(animeId);
    await prefs.setString(_bookmarkKey, jsonEncode(bookmarkList));
    print('Bookmark removed for animeId: $animeId');
  }

  static Future<bool> isAnimeBookmarked(int animeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> bookmarkList = prefs.containsKey(_bookmarkKey)
        ? List<int>.from(jsonDecode(prefs.getString(_bookmarkKey) ?? '[]'))
        : [];
    return bookmarkList.contains(animeId);
  }

  static Future<List<int>> getBookmarkList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> bookmarkList = prefs.containsKey(_bookmarkKey)
        ? List<int>.from(jsonDecode(prefs.getString(_bookmarkKey) ?? '[]'))
        : [];
    print('Bookmark List: $bookmarkList');
    return bookmarkList;
  }

  static Future<void> setBookmarkList(List<int> bookmarkList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_bookmarkKey, jsonEncode(bookmarkList));
    print('Bookmark List: $bookmarkList');
  }
}
