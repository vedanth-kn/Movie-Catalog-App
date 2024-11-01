import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'movie_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  String selectedGenre = 'All';
  String selectedSort = 'Title';

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
          controller: searchController,
          onChanged: (value) {
            movieProvider.searchMovies(value);
          },
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
          ),
        )
            : Text('Movie Catalog'),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  movieProvider.searchMovies('');
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Dropdown for Genre Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedGenre,
                    items: ['All', 'Action', 'Drama', 'Comedy', 'Horror']
                        .map((genre) => DropdownMenuItem(
                      value: genre,
                      child: Text(genre),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGenre = value!;
                      });
                      movieProvider.filterByGenre(selectedGenre);
                    },
                  ),
                ),
                // Dropdown for Sorting Options
                Expanded(
                  child: DropdownButton<String>(
                    value: selectedSort,
                    items: ['Title', 'Rating', 'Release Year']
                        .map((sortOption) => DropdownMenuItem(
                      value: sortOption,
                      child: Text(sortOption),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                      movieProvider.sortMovies(selectedSort);
                    },
                  ),
                ),
              ],
            ),
          ),
          // Movie List
          Expanded(
            child: Consumer<MovieProvider>(
              builder: (context, movieProvider, child) {
                if (movieProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return RefreshIndicator(
                  onRefresh: movieProvider.fetchMovies,
                  child: ListView.builder(
                    itemCount: movieProvider.filteredMovies.length,
                    itemBuilder: (context, index) {
                      final movie = movieProvider.filteredMovies[index];
                      return ListTile(
                        leading: Image.network(movie.poster),
                        title: Text(movie.title),
                        subtitle: Text(movie.year),
                        trailing: IconButton(
                          icon: Icon(
                            movieProvider.isFavorite(movie)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            movieProvider.toggleFavorite(movie);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailsScreen(movie: movie),
                            ),
                          );
                        },
                      );
                    },
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