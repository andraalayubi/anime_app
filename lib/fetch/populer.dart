import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/anime.dart';

Future<List<Anime>> fetch8Animes() async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime?limit=8'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((data) => Anime.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load anime list');
  }
}

Future<List<Anime>> fetchAnimes(int i) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime?page=$i'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((data) => Anime.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load anime list');
  }
}