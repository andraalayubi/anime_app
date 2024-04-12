import 'package:anime_app/components/list_vertical_anime.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart'; // Adjust the path as needed
import '../fetch/populer.dart';

class ListAnimePopuler extends StatefulWidget {
  @override
  _ListAnimePopulerState createState() => _ListAnimePopulerState();
}

class _ListAnimePopulerState extends State<ListAnimePopuler> {
  int halaman = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Most Popular #'+halaman.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        AnimeVerticalList(fetchAnimes: fetchAnimes, halaman: halaman),
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
