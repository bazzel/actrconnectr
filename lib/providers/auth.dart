import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String _apiKey;

  String get apiKey {
    return _apiKey;
  }

  void set apiKey(String newApiKey) {
    _apiKey = newApiKey;
    notifyListeners();
  }
}
