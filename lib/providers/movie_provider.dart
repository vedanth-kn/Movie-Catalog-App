import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> _filteredMovies = [];
  bool _isLoading = false;
  Set<Movie> _favorites = {};

  List<Movie> get movies => _movies;
  List<Movie> get filteredMovies => _filteredMovies;
  bool get isLoading => _isLoading;

  MovieProvider() {
    loadFavoritesFromLocalStorage();
  }

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    _movies = await MovieService().fetchMovies();
    _filteredMovies = _movies;

    _isLoading = false;
    notifyListeners();
  }

  void searchMovies(String query) {
    if (query.isEmpty) {
      _filteredMovies = _movies;
    } else {
      _filteredMovies = _movies
          .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterByGenre(String genre) {
    if (genre == 'All') {
      _filteredMovies = _movies;
    } else {
      _filteredMovies = _movies.where((movie) => movie.genre.contains(genre)).toList();
    }
    notifyListeners();
  }

  void sortMovies(String sortBy) {
    _filteredMovies.sort((a, b) {
      if (sortBy == 'Rating') return b.rating.compareTo(a.rating);
      if (sortBy == 'Release Year') return b.year.compareTo(a.year);
      return a.title.compareTo(b.title);
    });
    notifyListeners();
  }

  bool isFavorite(Movie movie) => _favorites.contains(movie);

  void toggleFavorite(Movie movie) {
    if (_favorites.contains(movie)) {
      _favorites.remove(movie);
    } else {
      _favorites.add(movie);
    }
    saveFavoritesToLocalStorage();
    notifyListeners();
  }

  void saveFavoritesToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteTitles = _favorites.map((movie) => movie.title).toList();
    prefs.setStringList('favorites', favoriteTitles);
  }

  Future<void> loadFavoritesFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteTitles = prefs.getStringList('favorites');
    if (favoriteTitles != null) {
      _favorites = _movies.where((movie) => favoriteTitles.contains(movie.title)).toSet();
    }
    notifyListeners();
  }
}