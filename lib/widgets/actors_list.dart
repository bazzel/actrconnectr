import 'package:actrconnectr/models/actor.dart';
import 'package:actrconnectr/providers/actors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            label: Text(actor.name),
            avatar: CircleAvatar(
              backgroundImage: (actor.profileImage != null)
                  ? NetworkImage(actor.profileImage)
                  : null,
            ),
            onDeleted: () {
              Provider.of<Actors>(context, listen: false).deleteActor(actor);
            },
          );
        }),
      ),
      spacing: 8.0,
    );
    // return ListView.builder(
    //   itemCount: _actors.length,
    //   itemBuilder: (ctx, i) {
    //     final actor = _actors[i];

    //     return ListTile(
    //       leading: CircleAvatar(
    //         backgroundImage: (actor.profileImage != null)
    //             ? NetworkImage(actor.profileImage)
    //             : null,
    //       ),
    //       title: Text(actor.name),
    //     );
    //   },
    // );
  }
}
