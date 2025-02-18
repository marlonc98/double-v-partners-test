import 'package:doublevpartners/data/repositories/auth/api/get_user_api_fake.dart';
import 'package:doublevpartners/data/repositories/auth/api/is_user_saved_api_impl.dart';
import 'package:doublevpartners/data/repositories/auth/api/login_with_email_and_password_api_fake.dart';
import 'package:doublevpartners/data/repositories/auth/api/login_with_fingerprint_api_impl.dart';
import 'package:doublevpartners/data/repositories/auth/api/logout_api_fake.dart';
import 'package:doublevpartners/data/repositories/auth/api/sign_up_with_email_and_password_api_fake.dart';
import 'package:doublevpartners/data/repositories/auth/api/verify_finger_print_api_impl.dart';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';

class AuthRepositoryFake implements AuthRepository {
  static const _SP_KEY = 'auth_dev_sp';

  @override
  Future<Either<ExceptionEntity, UserEntity>> login(
    String email,
    String password,
  ) => loginWithEmailAndPasswordApiFake(
    email: email,
    password: password,
    spKey: _SP_KEY,
  );

  @override
  Future<bool> logout() => logoutApiFake(_SP_KEY);

  @override
  Future<UserEntity?> getUser() => getCurrentUserApiFake(_SP_KEY);

  @override
  Future<VerifyFingerPrintResponse> verifyFingerPrint(String text) =>
      verifyFingerPrintApiImpl(text);

  @override
  Future<Either<ExceptionEntity, UserEntity>> signInWithSavedCredentials() =>
      loginWithFingerprintApiImpl(_SP_KEY);

  @override
  Future<String?> getSavedEmail() => getSavedEmailApiImpl(_SP_KEY);

  @override
  Future<Either<ExceptionEntity, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
    required DateTime birhtday,
  }) => signUpWithEmailAndPasswordApiFake(
    email: email,
    password: password,
    name: name,
    birthDate: birhtday,
    spKey: _SP_KEY,
  );
}
