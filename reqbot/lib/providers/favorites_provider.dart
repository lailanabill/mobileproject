import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteProjects = {};

  Set<String> get favoriteProjects => _favoriteProjects;

  void toggleFavorite(String projectName) {
    if (_favoriteProjects.contains(projectName)) {

