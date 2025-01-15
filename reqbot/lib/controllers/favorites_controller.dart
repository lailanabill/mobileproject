import 'package:reqbot/services/providers/favorites_provider.dart';

// Provides an interface between the UI and the FavoritesProvider
// This class acts as a bridge, handling interactions between the user interface and the underlying data provider.
class FavoritesController {
  final FavoritesProvider _favoritesProvider;

  // Constructor: Initializes the controller with an instance of FavoritesProvider
  // The FavoritesProvider is responsible for managing the list of favorite projects.
  FavoritesController(this._favoritesProvider);

  // Retrieves a list of favorite project names
  // This method accesses the list of favorite projects stored in the FavoritesProvider
  // and returns it as a new list to prevent direct manipulation of the underlying data.
  List<String> getFavoriteProjects() {
    return _favoritesProvider.favoriteProjects.toList();
  }

  // Toggles the favorite status of a project
  // If the project is already marked as a favorite, it will be removed from the favorites list.
  // Otherwise, the project will be added to the favorites list.
  // This method delegates the actual toggling logic to the FavoritesProvider.
  void toggleFavorite(String projectName) {
    _favoritesProvider.toggleFavorite(projectName);
  }
}
