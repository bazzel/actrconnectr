import "package:flappy_search_bar/flappy_search_bar.dart";
import "package:flutter/material.dart";

import "../models/actor.dart";

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

  void _handleOnTap(BuildContext context, Actor actor) {
    print("${actor.name} tapped...");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Actor"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SearchBar<Actor>(
            onSearch: (String query) => Actor.search(query),
            onItemFound: (Actor actor, int _index) =>
                _actorItem(actor, context),
          ),
        ),
      ),
    );
  }
}
