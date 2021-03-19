import 'package:actrconnectr/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_actor_screen.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Act'r Connect'r"),
      ),
      body: Consumer<Auth>(
        builder: (context, auth, child) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Lorem Ipsum",
              ),
              Text(
                auth.apiKey,
              ),
            ],
          ),
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
