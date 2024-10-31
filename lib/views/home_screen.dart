import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Catalog'),
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: movieProvider.fetchMovies,
            child: ListView.builder(
              itemCount: movieProvider.movies.length,
              itemBuilder: (context, index) {
                final movie = movieProvider.movies[index];
                return ListTile(
                  leading: Image.network(movie.poster),
                  title: Text(movie.title),
                  subtitle: Text(movie.year),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
