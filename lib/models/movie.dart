import "dart:convert" as convert;

import "package:equatable/equatable.dart";
import 'package:flutter/foundation.dart';
import "package:http/http.dart" as http;

class Movie extends Equatable {
  int id;
  String title;
  String posterPath;
  String backdropPath;
  String mediaType;

  Movie({
    @required this.id,
    @required this.title,
    @required this.posterPath,
    @required this.backdropPath,
    @required this.mediaType,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.title = json["title"] ?? json["name"];
    this.posterPath = json["poster_path"];
    this.backdropPath = json["backdrop_path"];
    this.mediaType = json["media_type"];
  }

  static Future<List<Movie>> combinedCreditsFor(
    int actorId,
    String apiKey,
  ) async {
    final url = Uri.https(
      "api.themoviedb.org",
      "3/person/$actorId/combined_credits",
      {
        "api_key": apiKey,
      },
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final results = jsonResponse["cast"];

      results.removeWhere(
          (element) => element["title"] == null && element["name"] == null);

      return List<Movie>.from(results.map((result) {
        return Movie.fromJson(result);
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

  String get backdropImage {
    if (backdropPath == null) return null;

    return "https://image.tmdb.org/t/p/w780/$backdropPath";
  }
}
