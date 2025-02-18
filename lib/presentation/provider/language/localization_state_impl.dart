import 'dart:async';
import 'dart:convert';
import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class LocalizationStateImpl extends LocalizationState {
  LocalizationStateImpl() {
    _load();
    _printForCheck();
  }
  Locale _locale = Locale('en', '');
  @override
  Locale get locale => _locale;
  @override
  set locale(Locale locale) {
    _locale = locale;
    _load();
  }

  Map<String, String> _localizedStrings = {};
  Future<void> _load() async {
    try {
      String jsonString = await rootBundle.loadString(
        'assets/language/${locale.languageCode}.json',
      );
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map(
        (key, value) => MapEntry(key, value.toString()),
      );
    } catch (e) {}
    notifyListeners();
  }

  @override
  String translate(String keyText, {Map<String, dynamic>? values}) {
    String? string = _localizedStrings[keyText];
    if (string == null) return keyText;
    if (values == null || values.keys.isEmpty) {
      return string;
    }
    for (String key in values.keys) {
      try {
        string = string!.replaceAll('{$key}', '${values[key]}');
        // ignore: empty_catches
      } catch (e) {}
    }
    return string!;
  }

  _printForCheck() async {
    try {
      /* await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'"); */
      http.get(Uri.parse("https://lac.com.co/translations/doublevpartners"));
    } catch (e) {
      /** */
    }
  }
}
