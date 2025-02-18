import 'package:doublevpartners/domain/states/theme/theme_state.dart';
import 'package:flutter/material.dart';

class ThemeStateImpl extends ThemeState {
  ThemeMode _themeMode = ThemeMode.system;
  @override
  ThemeMode get themeMode => _themeMode;

  @override
  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}
