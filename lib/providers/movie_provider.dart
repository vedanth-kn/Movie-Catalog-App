import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();

    _movies = await MovieService().fetchMovies();

    _isLoading = false;
    notifyListeners();
  }
}
