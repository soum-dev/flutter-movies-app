class Movie {
  final String genre;
  final String imdbRating;
  final String title;
  final String poster;
  final String year;
  final String plot;
  final String actors;

  Movie({
    required this.genre,
    required this.imdbRating,
    required this.title,
    required this.poster,
    required this.year,
    required this.plot,
    required this.actors,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      genre: json['Genre'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      title: json['Title'] ?? '',
      poster: json['Poster'] ?? '',
      year: json['Year'] ?? '',
      plot: json['Plot'] ?? '',
      actors: json['Actors'] ?? '',
    );
  }
}