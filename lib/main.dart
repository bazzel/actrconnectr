import 'package:actrconnectr/screens/home_screen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import 'providers/actors.dart';
import 'providers/auth.dart';
import "screens/add_actor_screen.dart";
import 'screens/add_api_key_screen.dart';
import 'screens/movie_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => Actors()),
      ],
      child: MaterialApp(
        title: "Act'r Connect'r",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          AddActorScreen.routeName: (context) => AddActorScreen(),
          AddAPIKeyScreen.routeName: (context) => AddAPIKeyScreen(),
          MovieDetailsScreen.routeName: (context) => MovieDetailsScreen(),
        },
      ),
    );
  }
}
