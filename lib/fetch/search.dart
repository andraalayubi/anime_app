import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/anime.dart';

Future<List<Anime>> searchAnimes(String i) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/anime?q=$i'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((data) => Anime.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load anime list');
  }
}