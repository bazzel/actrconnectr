import 'package:actrconnectr/screens/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/actors.dart';

class SameMoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sameMovies = context.watch<Actors>().sameMovies;

    return Expanded(
      child: ListView.separated(
        itemCount: sameMovies.length,
        itemBuilder: (context, index) {
          final movie = sameMovies[index];
          return ListTile(
            title: Text(movie.title),
            leading: ClipRect(
              child: (movie.posterImage != null)
                  ? Image.network(movie.posterImage)
                  : null,
            ),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              Navigator.of(context).pushNamed(
                MovieDetailsScreen.routeName,
                arguments: movie,
              );
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
