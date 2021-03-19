import 'package:actrconnectr/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAPIKeyScreen extends StatefulWidget {
  static const routeName = "/add-api-key";
  @override
  _AddAPIKeyScreenState createState() => _AddAPIKeyScreenState();
}

class _AddAPIKeyScreenState extends State<AddAPIKeyScreen> {
  final _formKey = GlobalKey<FormState>();

  void _handleOnFieldSubmitted() {
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add API Key"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Consumer<Auth>(
                  builder: (context, auth, child) => TextFormField(
                    initialValue: auth.apiKey,
                    decoration: InputDecoration(
                      labelText: "API Key",
                      helperText:
                          "You can obtain a free API Key from themoviedb.org",
                    ),
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      Provider.of<Auth>(context, listen: false).apiKey = value;
                    },
                    onFieldSubmitted: (_) {
                      _handleOnFieldSubmitted();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}
