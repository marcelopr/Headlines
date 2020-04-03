import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState extends ChangeNotifier {
  final String key = 'theme';
  bool _darkMode = false;
  bool _isLoaded = false;
  SharedPreferences _sharedPreferences;

  ThemeState() {
    _loadSharedPreferences();
  }

  _initSharedPreferences() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  _loadSharedPreferences() async {
    await _initSharedPreferences();
    _darkMode = _sharedPreferences.getBool(key) ?? false;
    _isLoaded = true;
    notifyListeners();
  }

  _savePreferences() async {
    await _initSharedPreferences();
    _sharedPreferences.setBool(key, _darkMode);
  }

  updateTheme(bool isDarkModeOn) {
    this._darkMode = isDarkModeOn;
    notifyListeners();
    _savePreferences();
  }

  bool get preferencesLoaded => this._isLoaded;

  bool get isDarkModeOn => _darkMode;
}
