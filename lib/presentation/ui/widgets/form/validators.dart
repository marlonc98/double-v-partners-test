// ignore_for_file: non_constant_identifier_names

import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/utils/date_format.dart';
import 'package:provider/provider.dart';

import 'form_widget.dart';

class Validators {
  static String? checkEmail({
    required dynamic text,
    required Map<String, dynamic> fields,
    required String key,
    required context,
  }) {
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(text);
    if (!emailValid) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(KeyWordsLocalization.ValidatorEmail);
    }
    return null;
  }

  static String? checkMinlength({
    required String? text,
    required Map<String, dynamic> fields,
    required minLength,
    required String key,
    required context,
  }) {
    if (text == null || text.length < minLength) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(
        KeyWordsLocalization.ValidatorMinlength,
        values: {'minLength': minLength},
      );
    }
    return null;
  }

  static String? checkMatchWithField({
    required String text,
    required Map<String, dynamic> fields,
    required String fieldName,
    required String fieldKey,
    required String key,
    required context,
  }) {
    if (text != fields[fieldKey]) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(
        KeyWordsLocalization.ValidatorMatchField,
        values: {'fieldName': fieldName},
      );
    }
    return null;
  }

  static String? checkRegExp({
    required dynamic text,
    required Map<String, dynamic> fields,
    required String key,
    required List<RegexFormError> regexs,
    required context,
  }) {
    final localization = Provider.of<LocalizationState>(context, listen: false);
    String error = regexs.fold(
      "",
      (acc, current) =>
          !current.regExp.hasMatch(text)
              ? "$acc ${localization.translate(current.error)}, "
              : "",
    );
    if (error.isNotEmpty) {
      return error.substring(0, error.length - 2);
    }
    return null;
  }

  static String? checkMinArrayLength({
    required dynamic values,
    required int minArrayLength,
    required Map<String, dynamic> fields,
    required String key,
    required context,
  }) {
    if (values == null || values.length < minArrayLength) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(
        KeyWordsLocalization.ValidatorMinArraylength,
        values: {'minLength': minArrayLength},
      );
    }
    return null;
  }

  static String? checkMaxLength({
    required dynamic text,
    required int maxLength,
    required context,
  }) {
    if (text.length > maxLength) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(
        KeyWordsLocalization.ValidatorMaxLength,
        values: {'maxLength': maxLength},
      );
    }
    return null;
  }

  static String? checkAutoComplete({required dynamic text, required context}) {
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(text);
    if (!emailValid) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(KeyWordsLocalization.ValidatorEmail);
    }
    return null;
  }

  static String? checkRequired({required dynamic text, required context}) {
    if (text == null || text == '' || (text is List && text.isEmpty)) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(KeyWordsLocalization.ValidatorRequired);
    }
    return null;
  }

  static String? checkAtLeastOneNumber({
    required dynamic text,
    required context,
  }) {
    bool hasOne = RegExp(r'(?=.*[0-9])').hasMatch(text);
    if (!hasOne) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(
        KeyWordsLocalization.ValidatorRequiresNumber,
      );
    }
    return null;
  }

  static String? checkAtLeastOneLowerCase({
    required dynamic text,
    required context,
  }) {
    bool hasOne = RegExp(r'(?=.*[a-z])').hasMatch(text);
    if (!hasOne) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(
        KeyWordsLocalization.ValidatorRequiresLowercase,
      );
    }
    return null;
  }

  static String? checkAtLeastOneUpperCase({
    required dynamic text,
    required context,
  }) {
    bool hasOne = RegExp(r'(?=.*[A-Z])').hasMatch(text);
    if (!hasOne) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(
        KeyWordsLocalization.ValidatorRequiresUppercase,
      );
    }
    return null;
  }

  static String? checkIfIsNumber({
    required dynamic text,
    required context,
    FormType? type,
  }) {
    final localization = Provider.of<LocalizationState>(context, listen: false);
    if (text != null &&
        text.length > 0 &&
        double.tryParse(text)?.toInt() == null) {
      return localization.translate(KeyWordsLocalization.ValidatorIsNotNumber);
    }
    return null;
  }

  static String? checkIfIsDouble({required dynamic text, required context}) {
    if (text != null && text.length > 0 && double.tryParse(text) == null) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      return localization.translate(KeyWordsLocalization.ValidatorIsNotDouble);
    }
    return null;
  }

  static String? checkMinDate({
    required dynamic text,
    required DateTime minDate,
    required context,
  }) {
    if (text != null && text.isBefore(minDate)) {
      final localization = Provider.of<LocalizationState>(
        context,
        listen: false,
      );
      //convert date to string
      DatesFormat.dateToMicroString(minDate, context);
      return localization.translate(
        KeyWordsLocalization.ValidatorMinDate,
        values: {'minDate': minDate},
      );
    }
    return null;
  }

  static String? check({
    bool isEmail = false,
    bool required = false,
    int? minLength,
    int? maxLength,
    int? minValue,
    int? maxValue,
    int? minArrayLength,
    FormType? type,
    String? matchFieldName,
    String? matchFieldKey,
    List<RegexFormError>? regexs,
    bool? atLeastOneLowercase,
    bool? atLeastOneUppercase,
    bool? atLeastOneNumber,
    DateTime? minDate,
    required dynamic text,
    required Map<String, dynamic> fields,
    required String key,
    required context,
  }) {
    text = text ?? fields[key];
    if (required) {
      String? check = Validators.checkRequired(text: text, context: context);
      if (check != null) return check;
    }
    if (isEmail && (required || text != null && text.isNotEmpty)) {
      String? check = Validators.checkEmail(
        text: text,
        fields: fields,
        key: key,
        context: context,
      );
      if (check != null) return check;
    }
    if (minDate != null && (required || text != null && text.isNotEmpty)) {
      String? check = Validators.checkMinDate(
        text: text,
        minDate: minDate,
        context: context,
      );
      if (check != null) return check;
    }
    if (atLeastOneLowercase == true) {
      String? check = Validators.checkAtLeastOneLowerCase(
        text: text,
        context: context,
      );
      if (check != null) return check;
    }
    if (atLeastOneUppercase == true) {
      String? check = Validators.checkAtLeastOneUpperCase(
        text: text,
        context: context,
      );
      if (check != null) return check;
    }
    if (atLeastOneNumber == true) {
      String? check = Validators.checkAtLeastOneNumber(
        text: text,
        context: context,
      );
      if (check != null) return check;
    }
    if (minLength != null && (required || text != null && text.isNotEmpty)) {
      String? check = Validators.checkMinlength(
        text: text,
        fields: fields,
        key: key,
        context: context,
        minLength: minLength,
      );
      if (check != null) return check;
    }
    if (matchFieldKey != null) {
      String? check = Validators.checkMatchWithField(
        text: text,
        fields: fields,
        key: key,
        context: context,
        fieldKey: matchFieldKey,
        fieldName: matchFieldName!,
      );
      if (check != null) return check;
    }
    if (minValue != null) {
      String? check = Validators.checkIfIsNumber(
        text: text,
        context: context,
        type: type,
      );
      if (check != null) return check;
      double? _parsedValue = double.tryParse(text);
      if (_parsedValue != null && _parsedValue < minValue) {
        final localization = Provider.of<LocalizationState>(
          context,
          listen: false,
        );
        return localization.translate(
          KeyWordsLocalization.ValidatorMinValue,
          values: {'minValue': minValue},
        );
      }
    }
    if (maxValue != null) {
      String? check = Validators.checkIfIsNumber(
        text: text,
        context: context,
        type: type,
      );
      if (check != null) return check;
      double? _parsedValue = double.tryParse(text);
      if (_parsedValue != null && _parsedValue > maxValue) {
        final localization = Provider.of<LocalizationState>(
          context,
          listen: false,
        );
        return localization.translate(
          KeyWordsLocalization.ValidatorMaxValue,
          values: {'maxValue': maxValue},
        );
      }
    }
    if (minArrayLength != null) {
      String? check = checkMinArrayLength(
        values: text,
        fields: fields,
        key: key,
        context: context,
        minArrayLength: minArrayLength,
      );
      if (check != null) return check;
    }
    if (maxLength != null) {
      String? check = checkMaxLength(
        text: text,
        maxLength: maxLength,
        context: context,
      );
      if (check != null) return check;
    }
    if (type == FormType.number) {
      String? check = checkIfIsNumber(text: text, context: context);
      if (check != null) return check;
    }
    if (type == FormType.double) {
      String? check = checkIfIsDouble(text: text, context: context);
      if (check != null) return check;
    }
    if (regexs != null) {
      String? check = Validators.checkRegExp(
        text: text,
        fields: fields,
        key: key,
        context: context,
        regexs: regexs,
      );
      if (check != null) return check;
    }

    //types
    if (type == FormType.number) {
      fields[key] = double.tryParse(text)?.toInt();
    } else if (type == FormType.double) {
      fields[key] = double.tryParse(text);
    } else {
      fields[key] = text;
    }
    return null;
  }
}

class RegexFormError {
  RegExp regExp;
  String error;

  RegexFormError({required this.regExp, required this.error});
}

final List<RegexFormError> VALIDATOR_PHONE = [
  RegexFormError(
    regExp: RegExp(r'^(?:[0-9] ?){5,13}[0-9]$'),
    error: KeyWordsLocalization.ValidatorCustomNoPhone,
  ),
];
final List<RegexFormError> VALIDATOR_PASSWORD = [
  RegexFormError(
    regExp: RegExp(
      r'(?=.*[\^$*.[\]{}()?"!@#%&/\\,><'
      r':;|_~`=+\- ])',
    ),
    error: KeyWordsLocalization.ValidatorCustomRequiresSpecialCharacter,
  ),
];

final List<RegexFormError> VALIDATOR_NAME = [
  VALIDATOR_NO_NUMBERS,
  VALIDATOR_NO_SPECIAL_CHARACTERS_FOR_NAME,
  RegexFormError(
    regExp: RegExp(r'^((?![\{}()?"!@#%&/\\,.:;|_~`=+\><]).)*$'),
    error: KeyWordsLocalization.ValidatorCustomNoName,
  ),
];

final RegexFormError VALIDATOR_NO_SPECIAL_CHARACTERS_FOR_NAME = RegexFormError(
  regExp: RegExp(r'^((?![\{}()?"!@#%&/\\,.:;|_~`=+\><]).)*$'),
  error: KeyWordsLocalization.ValidatorNotSpecialCharacters,
);

final RegexFormError VALIDATOR_NO_NUMBERS = RegexFormError(
  regExp: RegExp(r'^((?![0-9]).)*$'),
  error: KeyWordsLocalization.ValidatorNotNumber,
);
