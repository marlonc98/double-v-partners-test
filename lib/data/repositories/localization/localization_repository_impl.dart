import 'package:doublevpartners/domain/entities/option_locale_entity.dart';
import 'package:doublevpartners/domain/repositories/localization_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationRepositoryImpl extends LocalizationRepository {
  static const String LOCALIZATION_REPOSITORY_KEY =
      'localization_repository_key';
  List<OptionLocaleEntity> options = [
    OptionLocaleEntity(name: "English", locale: Locale("en", "")),
    OptionLocaleEntity(name: "Español", locale: Locale("es", "")),
  ];

  @override
  Future<void> changeLanguage(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LOCALIZATION_REPOSITORY_KEY, locale.languageCode);
  }

  @override
  Future<Locale?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString(LOCALIZATION_REPOSITORY_KEY);
    if (languageCode == null) {
      return null;
    }
    return options
        .firstWhere((element) => element.locale.languageCode == languageCode)
        .locale;
  }

  @override
  Future<List<OptionLocaleEntity>> getAvailableLanguages() {
    return Future.value(options);
  }
}
