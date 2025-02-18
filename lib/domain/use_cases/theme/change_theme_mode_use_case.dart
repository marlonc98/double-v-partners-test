import 'package:doublevpartners/domain/repositories/theme_repository.dart';
import 'package:doublevpartners/domain/states/theme/theme_state.dart';
import 'package:flutter/material.dart';

class ChangeThemeModeUseCase {
  final ThemeRepository themeRepository;
  final ThemeState themeProvider;

  ChangeThemeModeUseCase({
    required this.themeRepository,
    required this.themeProvider,
  });

  Future<void> call(ThemeMode themeMode) async {
    themeProvider.themeMode = themeMode;
    await themeRepository.changeTheme(themeMode);
  }
}
