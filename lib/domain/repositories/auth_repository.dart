import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:either_dart/either.dart';

enum VerifyFingerPrintResponse { success, fail, unavailable }

abstract class AuthRepository {
  Future<Either<ExceptionEntity, UserEntity>> login(
    String email,
    String password,
  );
  Future<void> logout();
  Future<UserEntity?> getUser();
  Future<VerifyFingerPrintResponse> verifyFingerPrint(String text);
  Future<String?> getSavedEmail();
  Future<Either<ExceptionEntity, UserEntity>> signInWithSavedCredentials();
  Future<Either<ExceptionEntity, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
    required DateTime birhtday,
  });
}
