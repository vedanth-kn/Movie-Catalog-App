import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  final String _apiKey = '4e618d27'; // Replace with your actual OMDb API key

  Future<List<Movie>> fetchMovies() async {
    final url = Uri.parse('http://www.omdbapi.com/?apikey=$_apiKey&s=Marvel&type=movie');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['Response'] == 'True') {
          final List moviesJson = jsonResponse['Search'];
          return moviesJson.map((json) => Movie.fromJson(json)).toList();
        } else {
          throw Exception(jsonResponse['Error'] ?? 'Unknown error');
        }
      } else {
        throw Exception('Failed to connect with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }
}
