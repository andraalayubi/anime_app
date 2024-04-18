import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/anime.dart';

Future<List<Anime>> searchAnimes({
  String? query,
  String? status,
  String? type,
  String? rating,
}) async {
  var baseUrl = 'https://api.jikan.moe/v4/anime';
  // var queryParams = <String, String>{};
  final Map<String, dynamic> queryParams = {};

  if (query != null) {
    queryParams['q'] = query;
  }
  if (status != null) {
    queryParams['status'] = status;
  }
  if (type != null) {
    queryParams['type'] = type;
  }
  if (rating != null) {
    queryParams['rating'] = rating;
  }

  var uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);
  print(uri);

  try {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((data) => Anime.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load animes');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to connect to the API');
  }
}

Future<Anime> animesById(int i) async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v4/anime/$i'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final Map<String, dynamic> animeData = jsonResponse['data'];
    final Anime anime = Anime.fromJson(animeData);
    return anime;
  } else {
    throw Exception('Failed to load anime');
  }
}
