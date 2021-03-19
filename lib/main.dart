import 'package:actrconnectr/screens/add_api_key_screen.dart';
import 'package:actrconnectr/screens/movies_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'providers/auth.dart';
import "screens/add_actor_screen.dart";
import 'screens/api_key_is_missing_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Auth(),
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          title: "Act'r Connect'r",
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: auth.apiKey == null ? APIKeyIsMissingScreen() : MoviesScreen(),
          routes: {
            AddActorScreen.routeName: (context) => AddActorScreen(),
            AddAPIKeyScreen.routeName: (context) => AddAPIKeyScreen(),
          },
        ),
      ),
    );
  }
}
