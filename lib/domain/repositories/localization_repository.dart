import 'package:doublevpartners/domain/entities/option_locale_entity.dart';
import 'package:flutter/material.dart';

abstract class LocalizationRepository {
  Future<List<OptionLocaleEntity>> getAvailableLanguages();
  Future<void> changeLanguage(Locale locale);
  Future<Locale?> getLanguage();
}
