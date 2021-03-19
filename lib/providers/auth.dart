import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _apiKey;

  Future<void> initValues() async {
    return _prefs.then((prefs) {
      _apiKey = prefs.getString('apiKey');
    });
  }

  String get apiKey {
    return _apiKey;
  }

  set apiKey(String newApiKey) {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('apiKey', newApiKey);
      _apiKey = newApiKey;
      notifyListeners();
    });
  }
}
