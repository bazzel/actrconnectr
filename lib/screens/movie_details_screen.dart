import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/actor.dart';
import '../models/movie.dart';
import '../providers/auth.dart';

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
                : null,
            SizedBox(
              height: 16.0,
            ),
            FutureBuilder(
              future: _fetchActors(movie.id, context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  final actors = snapshot.data;
                  return Expanded(
                    child: ListView.separated(
                      itemCount: actors.length,
                      itemBuilder: (context, index) {
                        final actor = actors[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: (actor.profileImage != null)
                                ? NetworkImage(actor.profileImage)
                                : null,
                          ),
                          title: Text(actor.name),
                          subtitle: Text(actor.character),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
                  );
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
