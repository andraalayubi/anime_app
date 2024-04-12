import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/anime.dart';

Future<List<Anime>> fetch8Popular() async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime?limit=8'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((data) => Anime.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load anime list');
  }
}

Future<List<Anime>> fetchAllPopular(int i) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime?page=$i'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((data) => Anime.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load anime list');
  }
}

Future<List<Anime>> fetch8AvailableNow() async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/seasons/now?limit=8'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((item) => Anime.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load available now anime');
  }
}

Future<List<Anime>> fetchAllAvailableNow(int i) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/seasons/now?page=$i'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((data) => Anime.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load anime list');
  }
}

Future<List<Anime>> fetch8ComingSoon() async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/seasons/upcoming?limit=8'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((item) => Anime.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load coming soon anime');
  }
}

Future<List<Anime>> fetchAllComingSoon(int i) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v4/seasons/upcoming?page=$i'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['data'];
    return jsonResponse.map((data) => Anime.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load anime list');
  }
}