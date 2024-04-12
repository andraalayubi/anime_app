import 'package:anime_app/fetch/populer.dart';
import 'package:flutter/material.dart';
import '../model/anime.dart'; // Adjust the path as needed
import '../fetch/search.dart'; // Adjust the path as needed

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedIndex = 1;
  late Future<List<Anime>> futureAnimes;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      futureAnimes = fetchAnimes(1);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearch(String query) {
    setState(() {
      futureAnimes = searchAnimes(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Page'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _onSearch(_searchController.text),
                ),
              ),
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
                      return Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
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
                                height: 100,
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
                                        fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Genres: ${anime.genres?.join(', ')}',
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Year: ${anime.year?.toString() ?? 'N/A'}',
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Rating: ${anime.ratingStars}',
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
