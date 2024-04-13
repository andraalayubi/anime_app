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

Future<List<Anime>> animesById(int i) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/anime/$i'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    // Disini Anda mengakses langsung data anime dari respons JSON
    final animeData = jsonResponse['data']; 
    // Ubah struktur data anime menjadi List<Anime>
    final List<Anime> animeList = [Anime.fromJson(animeData)]; 
    return animeList;
  } else {
    throw Exception('Failed to load anime list');
  }
}