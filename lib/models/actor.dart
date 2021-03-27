import "dart:convert" as convert;

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

import 'movie.dart';

class Actor extends Equatable {
  Actor({
    @required this.id,
    @required this.name,
    @required this.profilePath,
    @required this.knownFor,
    this.isSelected = true,
  });

  final int id;
  final String name;
  final String profilePath;
  final List<String> knownFor;
  List<Movie> movies;
  bool isSelected = true;

  @override
  List<Object> get props => [id];

  String get profileImage {
    if (profilePath == null) return null;

    return "https://image.tmdb.org/t/p/w185/$profilePath";
  }

  static Future<List<Actor>> search(
    String query,
    String apiKey,
  ) async {
    var url = Uri.https(
      "api.themoviedb.org",
      "/3/search/person",
      {
        "api_key": apiKey,
        "query": query,
      },
    );

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var results = jsonResponse["results"]
          .where((result) => result["known_for_department"] == "Acting")
          .toList();
      return List<Actor>.from(results.map((result) {
        var knownFor = List<String>.from(
            (result["known_for"]).map((item) => item["title"] ?? item["name"]));
        return Actor(
          id: result["id"],
          name: result["name"],
          profilePath: result["profile_path"],
          knownFor: knownFor,
        );
      }));
    } else {
      throw ("Request failed with status: ${response.statusCode}.");
    }
  }
}
