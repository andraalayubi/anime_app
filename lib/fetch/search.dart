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

Future<Anime> animesById(int i) async {
 final response = await http.get(Uri.parse('https://api.jikan.moe/v4/anime/$i'));

 if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    // Pastikan Anda mengakses data yang benar dari respons JSON
    // Misalnya, jika data anime berada di dalam kunci 'data', Anda harus mengaksesnya
    final Map<String, dynamic> animeData = jsonResponse['data']; 
    // Ubah struktur data anime menjadi Anime
    final Anime anime = Anime.fromJson(animeData); 
    return anime;
 } else {
    throw Exception('Failed to load anime');
 }
}