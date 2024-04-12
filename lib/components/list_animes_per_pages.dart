// ignore_for_file: unused_import

import 'package:anime_app/components/list_vertical_anime.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart'; // Adjust the path as needed
import '../fetch/fetch.dart';

class ListAnimesPerPages extends StatefulWidget {
  final Future<List<Anime>> Function(int halaman) fetch;
  final String title;

  ListAnimesPerPages({required this.fetch, required this.title});

  @override
  _ListAnimesPerPagesState createState() => _ListAnimesPerPagesState();
}

class _ListAnimesPerPagesState extends State<ListAnimesPerPages> {
  int halaman = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title+' #' + halaman.toString(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        AnimeVerticalList(fetchAnimes: widget.fetch, halaman: halaman),
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
