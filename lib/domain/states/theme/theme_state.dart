import 'package:flutter/material.dart';

abstract class ThemeState with ChangeNotifier {
  abstract ThemeMode themeMode;
}
