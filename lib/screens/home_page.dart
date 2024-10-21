import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_list/models/movie_model.dart';
import 'package:movie_list/screens/fade_transition.dart';
import 'package:movie_list/screens/movie_detailed_screen.dart';
import 'package:flutter/services.dart' show rootBundle;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _filterMovies(String query) {
    setState(() {
      _filteredMovies = _movies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _loadMovies() async {
    try {
      String jsonString = await rootBundle.loadString('assets/movies.json');
      List<dynamic> jsonList = json.decode(jsonString);
      setState(() {
        _movies = jsonList.map((json) => Movie.fromJson(json)).toList();
        _movies.sort((a, b) {
          double ratingA = double.tryParse(a.imdbRating) ?? 0.0;
          double ratingB = double.tryParse(b.imdbRating) ?? 0.0;
          return ratingB.compareTo(ratingA);
        });
        _filteredMovies = _movies;
      });
    } catch (e) {
      print('Error loading movies: $e');
      // Handle the error (e.g., show an error message to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MovieList",
          style: TextStyle(color: Colors.white60),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                  hintText: 'Search for a movie',
                  suffixIcon: Icon(Icons.search)),
              onChanged: _filterMovies,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMovies.length,
              itemBuilder: (context, index) {
                Movie movie = _filteredMovies[index];
                return ListTile(
                  leading: Image.network(
                    movie.poster,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.genre),
                  trailing: Text(
                    movie.imdbRating,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      FadePageRoute(page: MovieDetailedScreen(movie:movie))
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
