import 'package:flutter/material.dart';

import 'add_api_key_screen.dart';

class APIKeyIsMissingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Act'r Connect'r"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "You need to add an API Key first.",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddAPIKeyScreen.routeName);
              },
              child: Text("Add API Key"),
            ),
          ],
        ),
      ),
    );
  }
}
