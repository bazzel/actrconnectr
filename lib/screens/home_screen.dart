import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import 'api_key_is_missing_screen.dart';
import 'movies_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<Auth>().initValues(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return context.watch<Auth>().apiKey.isEmpty
              ? APIKeyIsMissingScreen()
              : MoviesScreen();
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
