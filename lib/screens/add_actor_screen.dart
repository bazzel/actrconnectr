import 'package:actrconnectr/models/movie.dart';
import "package:flappy_search_bar/flappy_search_bar.dart";
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "../models/actor.dart";
import '../providers/actors.dart';
import '../providers/auth.dart';

class AddActorScreen extends StatelessWidget {
  static const routeName = "/add-actor";

  ListTile _actorItem(Actor actor, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: (actor.profileImage != null)
            ? NetworkImage(actor.profileImage)
            : null,
      ),
      title: Text(actor.name),
      subtitle: Text(
        actor.knownFor.join(", "),
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () => _handleOnTap(
        context,
        actor,
      ),
    );
  }

  void _handleOnTap(BuildContext context, Actor actor) async {
    final apiKey = context.read<Auth>().apiKey;
    List<Movie> movies = await Movie.combinedCreditsFor(actor.id, apiKey);

    actor.movies = movies;
    context.read<Actors>().addActor(actor);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${actor.name} added."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final apiKey = context.read<Auth>().apiKey;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Actor"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SearchBar<Actor>(
            onSearch: (String query) => Actor.search(
              query,
              apiKey,
            ),
            onItemFound: (Actor actor, int _index) =>
                _actorItem(actor, context),
          ),
        ),
      ),
    );
  }
}
