// ignore_for_file: unused_import

import 'package:anime_app/components/list_vertical_anime.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart'; // Adjust the path as needed
import '../fetch/fetch.dart';

class ListAvailableAnime extends StatefulWidget {
  @override
  _ListAvailableAnimeState createState() => _ListAvailableAnimeState();
}

class _ListAvailableAnimeState extends State<ListAvailableAnime> {
  int halaman = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Avalilable Now #'+halaman.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        AnimeVerticalList(fetchAnimes: fetchAllAvailableNow, halaman: halaman),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (halaman > 1) {
                  setState(() {
                    halaman--;
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                setState(() {
                  halaman++;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
