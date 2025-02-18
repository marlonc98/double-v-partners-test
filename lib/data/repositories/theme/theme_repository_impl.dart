import 'package:doublevpartners/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepositoryImpl extends ThemeRepository {
  static const String _THEME_REPOSITORY_KEY = 'theme_repository_key';
  @override
  Future<void> changeTheme(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_THEME_REPOSITORY_KEY, themeMode.toString());
  }

  @override
  Future<ThemeMode?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeMode = prefs.getString(_THEME_REPOSITORY_KEY);
    if (themeMode == null) {
      return null;
    }
    return ThemeMode.values.firstWhere(
      (element) => element.toString() == themeMode,
    );
  }
}
