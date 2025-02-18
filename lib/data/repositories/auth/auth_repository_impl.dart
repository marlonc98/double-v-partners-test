import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/repositories/auth_repository.dart';
import 'package:either_dart/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const _SP_KEY = 'auth_impl_sp';

  @override
  Future<UserEntity?> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<ExceptionEntity, UserEntity>> login(
    String email,
    String password,
  ) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<VerifyFingerPrintResponse> verifyFingerPrint(String text) {
    // TODO: implement verifyFingerPrint
    throw UnimplementedError();
  }

  @override
  Future<Either<ExceptionEntity, UserEntity>> signInWithSavedCredentials() {
    // TODO: implement signInWithSavedCredentials
    throw UnimplementedError();
  }

  @override
  Future<String?> getSavedEmail() {
    // TODO: implement isUserSaved
    throw UnimplementedError();
  }

  @override
  Future<Either<ExceptionEntity, UserEntity>> signUp({
    required String email,
    required String password,
    required String name,
    required DateTime birhtday,
  }) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
