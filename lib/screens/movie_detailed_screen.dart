import 'package:flutter/material.dart';
import 'package:movie_list/models/movie_model.dart';

class MovieDetailedScreen extends StatelessWidget{
  final Movie movie;

  const MovieDetailedScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(movie.poster, width:double.infinity,height: 300, fit: BoxFit.cover,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text('Title: ${movie.title}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Year: ${movie.year}'),
                  const SizedBox(height: 8),
                  Text('Genre: ${movie.genre}'),
                  const SizedBox(height: 8),
                  Text('IMDb Rating: ${movie.imdbRating}'),
                  const SizedBox(height: 8),
                  Text('Actors: ${movie.actors}'),
                  const SizedBox(height: 16),
                  const Text('Plot:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(movie.plot),
              ],
            ),
          )
        ],

        ),
      ),
    );
  }
}