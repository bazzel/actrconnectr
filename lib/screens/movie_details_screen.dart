import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/actor.dart';
import '../models/movie.dart';
import '../providers/auth.dart';
import '../providers/actors.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const routeName = '/movie-details';

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            (movie.backdropImage != null)
                ? Image.network(movie.backdropImage)
                : Placeholder(
                    fallbackHeight: 210,
                  ),
            SizedBox(
              height: 16.0,
            ),
            FutureBuilder(
              future: _fetchActors(movie.id, context),
              builder: (context, snapshot) {
                try {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    final actors = snapshot.data;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: actors.length,
                        itemBuilder: (ctx, index) {
                          final actor = actors[index];
                          final isIncluded =
                              context.watch<Actors>().actors.contains(actor);

                          return SwitchListTile(
                            title: Text(actor.name),
                            subtitle: Text(actor.character),
                            value: isIncluded,
                            onChanged: (bool value) async {
                              if (value) {
                                final apiKey = context.read<Auth>().apiKey;
                                List<Movie> movies =
                                    await Movie.combinedCreditsFor(
                                        actor.id, apiKey);

                                actor.movies = movies;

                                context.read<Actors>().addActor(actor);
                              } else {
                                context.read<Actors>().deleteActor(actor);
                              }
                            },
                            secondary: CircleAvatar(
                              backgroundImage: (actor.profileImage != null)
                                  ? NetworkImage(actor.profileImage)
                                  : null,
                            ),
                          );
                        },
                      ),
                    );
                  }
                } catch (e) {
                  return Text('No author details available.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Actor>> _fetchActors(int movieId, BuildContext context) {
    var apiKey = context.watch<Auth>().apiKey;
    return Actor.actorsFor(movieId, apiKey);
  }
}
