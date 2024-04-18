// ignore_for_file: unused_import

import 'package:anime_app/components/list_vertical_anime.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart';
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
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.title + ' #' + halaman.toString(),
            style: const TextStyle(fontSize: 24),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
          AnimeVerticalList(fetchAnimes: widget.fetch, halaman: halaman),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (halaman > 1)
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      halaman--;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              Spacer(),
              if (halaman < 17)
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      halaman++;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(12),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
