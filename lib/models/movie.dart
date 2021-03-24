import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import "package:equatable/equatable.dart";

import 'actor.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String mediaType;

  Movie({
    @required this.id,
    @required this.title,
    @required this.posterPath,
    @required this.mediaType,
  });

  static Future<List<Movie>> combinedCreditsFor(
      Actor actor, String apiKey) async {
    var url = Uri.https(
      "api.themoviedb.org",
      "3/person/${actor.id}/combined_credits",
      {
        "api_key": apiKey,
      },
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List results = jsonResponse["cast"];

      results.removeWhere((element) => element["title"] == null);

      return List<Movie>.from(results.map((result) {
        return Movie(
          id: result["id"],
          title: result["title"],
          posterPath: result["poster_path"],
          mediaType: result["media_type"],
        );
      }));
    } else {
      throw ("Request failed with status: ${response.statusCode}.");
    }
  }

  @override
  List<Object> get props => [id];

  String get posterImage {
    if (posterPath == null) return null;

    return "https://image.tmdb.org/t/p/w185/$posterPath";
  }
}
