import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<void> changeTheme(ThemeMode themeMode);
  Future<ThemeMode?> getTheme();
}
