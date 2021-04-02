import 'package:actrconnectr/screens/movie_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/actors.dart';

class SameMoviesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _actorsProvider = Provider.of<Actors>(context);
    final _sameMovies = _actorsProvider.sameMovies;

    return Expanded(
      child: ListView.separated(
        itemCount: _sameMovies.length,
        itemBuilder: (context, index) {
          final movie = _sameMovies[index];
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
