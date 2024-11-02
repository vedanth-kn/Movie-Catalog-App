# Movie Catalog App

The *Movie Catalog App* is a Flutter-based mobile application that allows users to browse a collection of movies, view detailed information, and organize favorites. This app features essential functionalities such as movie search, filtering, sorting, and favoriting with a clean, responsive UI following Material Design guidelines. Movie data is dynamically fetched from a public API (OMDb or TMDb), providing up-to-date information on popular films.

## Key Features

- *Movie List and Details*: Browse a list of movies with essential details and tap on any movie to view a dedicated page with a full synopsis, genre, release date, and rating.
- *Search and Filter*: Easily search movies by title and apply filters by genre or release year. Sort movies by rating, release year, or title to quickly find specific results.
- *Favorites*: Mark movies as favorites and view them in a separate list, which is saved locally for access even after the app is closed.
- *Error Handling and Loading States*: The app handles API errors gracefully, with error messages and loading indicators to enhance user experience.

## Additional Enhancements

- *UI/UX*: A responsive, visually appealing UI optimized for various screen sizes and a consistent look aligned with Material Design principles.
- *Testing*: Comprehensive unit, widget, and integration tests ensure a smooth and bug-free experience.
- *Bonus*: Optional features like Dark Mode and smooth animations for a polished user interface.

## Technical Stack

- *Flutter & Dart*: Built with the latest stable version of Flutter and best practices in Dart.
- *State Management*: Managed app state with a provider for efficient and organized state handling.
- *API Integration*: Integrated with a REST API using http or Dio for fetching movie data.
- *Local Storage*: Used SQLite or Hive to store favorite movies locally.
- *Version Control*: Followed best practices in version control with descriptive commit messages for maintainability.
