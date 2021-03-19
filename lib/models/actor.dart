import "dart:convert" as convert;

import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class Actor {
  Actor({
    @required this.id,
    @required this.name,
    @required this.profilePath,
    @required this.knownFor,
  });

  final int id;
  final List<String> knownFor;
  final String name;
  final String profilePath;

  static Future<List<Actor>> search(String query, String apiKey) async {
    // "777a076f90fe0b98a0c46079c7186f43"
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
      return results
          .map((result) {
            var knownFor = (result["known_for"] as List)
                .map((item) => item["title"] ?? item["name"])
                .toList()
                .cast<String>();
            return Actor(
              id: result["id"],
              name: result["name"],
              profilePath: result["profile_path"],
              knownFor: knownFor,
            );
          })
          .toList()
          .cast<Actor>();
    } else {
      throw ("Request failed with status: ${response.statusCode}.");
    }
  }

  String get profileImage {
    if (profilePath == null) return null;

    return "https://image.tmdb.org/t/p/w185/$profilePath";
  }
}
