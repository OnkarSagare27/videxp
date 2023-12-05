import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider extends ChangeNotifier {
  bool _isSignedIn = false;

  bool get isSignedIn => _isSignedIn;

  AuthenticationProvider() {
    checkSignedIn();
  }

  void checkSignedIn() async {
    final SharedPreferences preffs = await SharedPreferences.getInstance();
    _isSignedIn = preffs.getBool('is_signedin') ?? false;
    notifyListeners();
  }

  static Future<bool> get statusIsSingedIn async {
    final SharedPreferences preffs = await SharedPreferences.getInstance();
    bool status = preffs.getBool('isSignedIn') ?? false;
    return status;
  }
}
