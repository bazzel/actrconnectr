import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AddAPIKeyScreen extends StatelessWidget {
  static const routeName = "/add-api-key";

  final _formKey = GlobalKey<FormState>();

  void _handleOnFieldSubmitted() {
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Key"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                TextFormField(
                  initialValue: context.read<Auth>().apiKey,
                  decoration: InputDecoration(
                    labelText: "API Key",
                    helperText:
                        "You can obtain a free API Key from themoviedb.org",
                  ),
                  textInputAction: TextInputAction.done,
                  onSaved: (value) {
                    context.read<Auth>().apiKey = value;
                  },
                  onFieldSubmitted: (_) {
                    _handleOnFieldSubmitted();
                    Navigator.of(context).pop();
                  },
                ),
              ]),
            )),
      ),
    );
  }
}
