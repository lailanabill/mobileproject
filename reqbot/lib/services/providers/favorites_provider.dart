import 'package:flutter/material.dart';

// FavoritesProvider is a ChangeNotifier-based state management class
// that maintains a list of favorite projects and notifies listeners
// when the list changes.
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteProjects = {}; // A Set to store favorite project names.

  // Getter to access the set of favorite projects.
  // This provides a read-only view of the favorites.
  Set<String> get favoriteProjects => _favoriteProjects;

  // Toggles the favorite status of a project.
  //
  // If the project is already a favorite, it will be removed from the set.
  // Otherwise, it will be added to the set.
  // Notifies listeners of the change, so the UI can react accordingly.
  void toggleFavorite(String projectName) {
    if (_favoriteProjects.contains(projectName)) {
      _favoriteProjects.remove(projectName); // Removes the project if it exists.
    } else {
      _favoriteProjects.add(projectName); // Adds the project if it doesn't exist.
    }
    notifyListeners(); // Notifies all listeners about the state change.
  }

  // Checks if a project is marked as a favorite.
  //
  // Parameters:
  // - projectName: The name of the project to check.
  //
  // Returns:
  // - true if the project is a favorite; false otherwise.
  bool isFavorite(String projectName) {
    return _favoriteProjects.contains(projectName);
  }
}
