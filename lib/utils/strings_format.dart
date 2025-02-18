import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class StringsFormat {
  /// Input a sentence, return a sentence with the first letter of each word capitalized
  static String getFirstLetterAsCapitalize(String text) {
    if (text.isEmpty) return '';
    final List<String> words = text.split(' ');
    String result = '';
    for (final String word in words) {
      result += word[0].toUpperCase();
    }
    return result.trim();
  }

  static String capitalizeFirst(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  static String lowerCaseFirst(String text) {
    if (text.isEmpty) return '';
    return text[0].toLowerCase() + text.substring(1);
  }

  static Future<String> loadVersionAndBuildNumber(BuildContext context) async {
    final LocalizationState localization = Provider.of<LocalizationState>(
      context,
      listen: false,
    );
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return localization.translate(
      KeyWordsLocalization.VersionAndBuild,
      values: {
        "version": packageInfo.version,
        "build": packageInfo.buildNumber,
      },
    );
  }
}
