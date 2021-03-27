import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/actor.dart';
import '../providers/actors.dart';

class ActorsList extends StatefulWidget {
  @override
  _ActorsListState createState() => _ActorsListState();
}

class _ActorsListState extends State<ActorsList> {
  @override
  Widget build(BuildContext context) {
    final _actorsProvider = Provider.of<Actors>(context);
    final _actors = _actorsProvider.actors;
    return Wrap(
      children: List<Widget>.from(
        _actors.map((Actor actor) {
          return InputChip(
            selected: actor.isSelected,
            label: Text(actor.name),
            avatar: CircleAvatar(
              backgroundImage: (actor.profileImage != null)
                  ? NetworkImage(actor.profileImage)
                  : null,
            ),
            onSelected: (bool _newValue) {
              setState(() {
                _actorsProvider.toggle(actor);
              });
            },
            onDeleted: () {
              Provider.of<Actors>(context, listen: false).deleteActor(actor);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${actor.name} removed."),
                ),
              );
            },
          );
        }),
      ),
      spacing: 8.0,
    );
  }
}
