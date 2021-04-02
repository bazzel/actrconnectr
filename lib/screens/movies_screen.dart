import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/actors_list.dart';
import '../widgets/same_movies_list.dart';
import 'add_actor_screen.dart';
import 'add_api_key_screen.dart';

enum AppBarMenu { apiKey }

class MoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Act'r Connect'r"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                child: Text("API Key"),
                value: AppBarMenu.apiKey,
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case AppBarMenu.apiKey:
                  Navigator.of(context).pushNamed(AddAPIKeyScreen.routeName);
                  break;
                default:
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ActorsList(),
            SameMoviesList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddActorScreen.routeName);
        },
        tooltip: "Add Actor",
        child: Icon(Icons.add),
      ),
    );
  }
}
