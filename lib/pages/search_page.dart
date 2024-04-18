import 'package:anime_app/components/filter_search.dart';
import 'package:anime_app/pages/bookmark_page.dart';
import 'package:anime_app/pages/detail_anime_page.dart';
import 'package:anime_app/pages/home_page.dart';
import 'package:anime_app/fetch/fetch.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart'; // Adjust the path as needed
import '../fetch/search.dart'; // Adjust the path as needed

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Future<List<Anime>> futureAnimes;
  int _selectedIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  //Deklarasi variabel filter
  String? _selectedStatus;
  String? _selectedType;
  String? _selectedRating;

  @override
  void initState() {
    super.initState();
    setState(() {
      futureAnimes = searchAnimes();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookmarkPage()),
        );
      }
    });
  }

  void _onSearch(String query) {
    setState(() {
      futureAnimes = searchAnimes(
          query: query,
          status: _selectedStatus,
          type: _selectedType,
          rating: _selectedRating);
    });
  }
  
  void _onFilterChanged(String? status, String? type, String? rating) {
    setState(() {
      _selectedStatus = status;
      _selectedType = type;
      _selectedRating = rating;
      _onSearch(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 14.0, right: 8, left: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                focusColor: Colors.blue,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _onSearch(_searchController.text),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: AnimeFilter(
              onFilterChanged: _onFilterChanged,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Anime>>(
              future: futureAnimes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Anime> animes = snapshot.data!;
                  return ListView.builder(
                    itemCount: animes.length,
                    itemBuilder: (context, index) {
                      Anime anime = animes[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AnimeDetailPage(id: anime.malId)),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.secondary,
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  anime.imageUrl,
                                  width: 100,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      anime.title,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).colorScheme.secondary),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Genres: ${anime.genres?.join(', ')}',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Year: ${anime.year?.toString() ?? 'N/A'}',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      'Rating: ${anime.ratingStars}',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                // Displaying a loading spinner until the data is ready
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.tertiary,
        onTap: _onItemTapped,
      ),
    );
  }
}