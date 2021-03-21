import 'package:actrconnectr/models/actor.dart';
import 'package:flutter/foundation.dart';

class Actors with ChangeNotifier {
  var _actors = <Actor>[];

  List<Actor> get actors {
    return [..._actors];
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
