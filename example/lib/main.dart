import 'package:flutter/material.dart';
import 'package:flutter_highlight_search_text/flutter_highlight_search_text.dart';

void main() {
  runApp(const FilmListApp());
}

class Film {
  final String name;
  final String description;
  final int year;
  final String director;
  final String genre;

  Film({
    required this.name,
    required this.description,
    required this.year,
    required this.director,
    required this.genre,
  });
}

class FilmListApp extends StatelessWidget {
  const FilmListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Film List',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          titleLarge: const TextStyle(fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: Colors.grey[600]),
        ),
      ),
      home: const FilmListScreen(),
    );
  }
}

class FilmListScreen extends StatefulWidget {
  const FilmListScreen({super.key});

  @override
  _FilmListScreenState createState() => _FilmListScreenState();
}

class _FilmListScreenState extends State<FilmListScreen> {
  List<Film> films = [
    Film(
      name: 'Inception',
      description:
          'A skilled thief who steals corporate secrets through dream-sharing technology is given a chance to erase his criminal history by planting an idea into the mind of a CEO.',
      year: 2010,
      director: 'Christopher Nolan',
      genre: 'Science Fiction',
    ),
    Film(
      name: 'The Shawshank Redemption',
      description:
          'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
      year: 1994,
      director: 'Frank Darabont',
      genre: 'Drama',
    ),
    Film(
      name: 'The Godfather',
      description:
          'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
      year: 1972,
      director: 'Francis Ford Coppola',
      genre: 'Crime',
    ),
    Film(
      name: 'The Dark Knight',
      description:
          'When the menace known as the Joker emerges from his mysterious past, he wreaks havoc and chaos on the people of Gotham.',
      year: 2008,
      director: 'Christopher Nolan',
      genre: 'Action',
    ),
    Film(
      name: 'Pulp Fiction',
      description:
          'The lives of two mob hitmen, a boxer, a gangster, and his wife intertwine in four tales of violence and redemption.',
      year: 1994,
      director: 'Quentin Tarantino',
      genre: 'Crime',
    ),
    Film(
      name: 'The Lord of the Rings: The Fellowship of the Ring',
      description:
          'A young hobbit, Frodo, is tasked with destroying an all-powerful ring that could bring doom to Middle-earth.',
      year: 2001,
      director: 'Peter Jackson',
      genre: 'Fantasy',
    ),
    Film(
      name: 'The Matrix',
      description:
          'A computer hacker learns about the true nature of his reality and his role in the war against its controllers.',
      year: 1999,
      director: 'The Wachowskis',
      genre: 'Science Fiction',
    ),
    Film(
      name: 'Forrest Gump',
      description:
          'The story of a man with a low IQ who unintentionally influences some of the biggest events of the 20th century in the USA.',
      year: 1994,
      director: 'Robert Zemeckis',
      genre: 'Drama',
    ),
    Film(
      name: 'Star Wars: Episode IV - A New Hope',
      description:
          'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, and two droids to save the galaxy from the Empire’s world-destroying battle station.',
      year: 1977,
      director: 'George Lucas',
      genre: 'Science Fiction',
    ),
    Film(
      name: 'Fight Club',
      description:
          'An insomniac office worker and a soap salesman form an underground fight club that evolves into something much more.',
      year: 1999,
      director: 'David Fincher',
      genre: 'Drama',
    ),
  ];

  List<Film> filteredFilms = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredFilms = films;
  }

  void updateSearchQuery(String query) {
    setState(() {
      searchQuery = query;
      filteredFilms = films.where((film) {
        final lowerCaseQuery = searchQuery.toLowerCase();
        return film.name.toLowerCase().contains(lowerCaseQuery) ||
            film.description.toLowerCase().contains(lowerCaseQuery) ||
            film.director.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Film List'),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                labelText: 'Search films...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: filteredFilms.length,
              itemBuilder: (context, index) {
                Film film = filteredFilms[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: SearchHighlightText(
                        text: film.name,
                        query: searchQuery,
                        textStyle: Theme.of(context).textTheme.titleLarge,
                        highlightTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.blue),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child:
                        SearchHighlightText(
                          text: '${film.description}\n\n${film.director} • ${film.year}',
                          query: searchQuery,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          highlightTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.blue),
                          maxLines: 10,
                        ),
                      ),
                      isThreeLine: true,
                      onTap: () {
                        // Implement onTap to navigate to a detail screen or show more info
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
