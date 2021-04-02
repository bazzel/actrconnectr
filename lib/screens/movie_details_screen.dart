import 'package:actrconnectr/models/actor.dart';
import 'package:actrconnectr/models/movie.dart';
import 'package:actrconnectr/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const routeName = '/movie-details';

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final Movie _movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_movie.title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            (_movie.backdropImage != null)
                ? Image.network(_movie.backdropImage)
                : null,
            SizedBox(
              height: 16.0,
            ),
            FutureBuilder(
              future: _fetchActors(_movie.id),
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

  Future<List<Actor>> _fetchActors(int movieId) {
    var apiKey = Provider.of<Auth>(context, listen: false).apiKey;
    return Actor.actorsFor(movieId, apiKey);
  }
}
