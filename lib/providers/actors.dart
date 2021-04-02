import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/actor.dart';
import '../models/movie.dart';

class Actors with ChangeNotifier {
  // Use a Set to avoid duplicate Actors.
  var _actors = <Actor>{};

  UnmodifiableListView<Actor> get actors => UnmodifiableListView(_actors);

  List<Movie> get sameMovies {
    Set<Movie> movies;

    if (selectedActors.isEmpty) {
      return [];
    }

    selectedActors.forEach((actor) {
      if (movies == null) {
        movies = Set<Movie>.from(actor.movies);
      } else {
        movies = movies.intersection(Set<Movie>.from(actor.movies));
      }
    });

    return List<Movie>.from(movies);
  }

  List<Actor> get selectedActors =>
      List<Actor>.of(actors.where((actor) => actor.isSelected));

  void addActor(Actor actor) {
    _actors.add(actor);
    notifyListeners();
  }

  void toggle(Actor actor) {
    actor.isSelected = !actor.isSelected;
    notifyListeners();
  }

  void deleteActor(Actor actor) {
    _actors.remove(actor);
    notifyListeners();
  }
}
