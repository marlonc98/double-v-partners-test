import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/domain/repositories/localization_repository.dart';
import 'package:flutter/material.dart';

class ChangeLanguageUseCase {
  final LocalizationRepository localizationRepository;
  final LocalizationState localizationState;

  ChangeLanguageUseCase({
    required this.localizationRepository,
    required this.localizationState,
  });

  Future<void> call(Locale locale) async {
    localizationState.locale = locale;
    await localizationRepository.changeLanguage(locale);
  }
}
