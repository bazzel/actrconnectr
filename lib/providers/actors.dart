import 'package:flutter/foundation.dart';

import '../models/actor.dart';
import '../models/movie.dart';

class Actors with ChangeNotifier {
  var _actors = <Actor>[];

  List<Actor> get actors {
    return [..._actors];
  }

  List<Movie> get sameMovies {
    Set<Movie> movies;

    if (_actors.isEmpty) {
      return [];
    }

    _actors.forEach((actor) {
      if (movies == null) {
        movies = Set<Movie>.from(actor.movies);
      } else {
        movies = movies.intersection(Set<Movie>.from(actor.movies));
      }
    });

    return List<Movie>.from(movies);
  }

  void addActor(Actor actor) {
    _actors.add(actor);
    notifyListeners();
  }

  void deleteActor(Actor actor) {
    _actors.remove(actor);
    notifyListeners();
  }
}
