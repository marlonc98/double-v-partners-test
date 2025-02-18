import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DatesFormat {
  // final BuildContext context;

  // DatesFormat({required this.context});

  // LocalizationState localization =
  //       Provider.of<LocalizationState>(context, listen: false);

  static String dateToMicroString(DateTime? date, BuildContext context) {
    final LocalizationState localization = Provider.of<LocalizationState>(
      context,
      listen: false,
    );
    return date != null
        ? DateFormat('dd/MM/yyyy').format(date)
        : localization.translate(KeyWordsLocalization.DatesFormatWithoutDate);
  }

  static String dateToMicroStringWithHour(
    DateTime? date,
    BuildContext context,
  ) {
    final LocalizationState localization = Provider.of<LocalizationState>(
      context,
      listen: false,
    );
    return date != null
        ? DateFormat('dd/MM/yyyy hh:mm').format(date)
        : localization.translate(KeyWordsLocalization.DatesFormatWithoutDate);
  }

  static String dateToMicroStringWith12HoursFormat(
    DateTime? date,
    BuildContext context,
  ) {
    final LocalizationState localization = Provider.of<LocalizationState>(
      context,
      listen: false,
    );
    String dateFormatted =
        date != null
            ? DateFormat('dd/MM/yyyy hh:mm a').format(date)
            : localization.translate(
              KeyWordsLocalization.DatesFormatWithoutDate,
            );
    return dateFormatted;
  }

  static String getMonthAndYear(DateTime date, BuildContext context) {
    final LocalizationState localization = Provider.of<LocalizationState>(
      context,
      listen: false,
    );
    List<String> months = [
      KeyWordsLocalization.January,
      KeyWordsLocalization.February,
      KeyWordsLocalization.March,
      KeyWordsLocalization.April,
      KeyWordsLocalization.May,
      KeyWordsLocalization.June,
      KeyWordsLocalization.July,
      KeyWordsLocalization.August,
      KeyWordsLocalization.September,
      KeyWordsLocalization.October,
      KeyWordsLocalization.November,
      KeyWordsLocalization.December,
    ];

    return "${localization.translate(months[date.month - 1])} ${date.year}";
  }

  static String getDayMonthAndYear(DateTime date, BuildContext context) {
    String monthAndYear = getMonthAndYear(date, context);
    return "${date.day} $monthAndYear";
  }
}
