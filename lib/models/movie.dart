class Movie {
  final String title;
  final String year;
  final String poster;
  final String plot;
  final String genre;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.genre,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
      genre: json['Genre'] ?? '',
      rating: double.tryParse(json['imdbRating']?.toString() ?? '0.0') ?? 0.0,  // Safely parse rating as double
    );
  }
}