import 'dart:convert';

import 'package:doublevpartners/data/repositories/auth/api/login_with_email_and_password_api_fake.dart';
import 'package:doublevpartners/data/repositories/auth/api/verify_finger_print_api_impl.dart';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/repositories/auth_repository.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Either<ExceptionEntity, UserEntity>> loginWithFingerprintApiImpl(
  String spKey,
) async {
  VerifyFingerPrintResponse response = await verifyFingerPrintApiImpl(
    "You can use your fingerprint to get a faster login",
  );
  if (response == VerifyFingerPrintResponse.success) {
    final secureStorage = FlutterSecureStorage();
    final credentials = await secureStorage.read(key: "${spKey}_current_user");
    if (credentials == null) {
      return Left(
        ExceptionEntity(
          code: KeyWordsLocalization.LocalAuthUseFingerprintError,
        ),
      );
    }
    final mapped = jsonDecode(credentials);
    final responseLogin = loginWithEmailAndPasswordApiFake(
      email: mapped['email'],
      password: mapped['password'],
      spKey: spKey,
    );
    return responseLogin;
  } else if (response == VerifyFingerPrintResponse.unavailable) {
    return Left(
      ExceptionEntity(code: KeyWordsLocalization.LocalAuthUnavailable),
    );
  } else {
    return Left(
      ExceptionEntity(code: KeyWordsLocalization.LocalAuthUseFingerprintError),
    );
  }
}
