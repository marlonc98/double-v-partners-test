import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/states/user/user_state.dart';
import 'package:either_dart/either.dart';
import '../../repositories/auth_repository.dart';

class SignInWithFingerPrintUseCase {
  final AuthRepository authRepository;
  final UserState userState;

  SignInWithFingerPrintUseCase({
    required this.authRepository,
    required this.userState,
  });

  Future<Either<ExceptionEntity, UserEntity>> call() async {
    Either<ExceptionEntity, UserEntity> response =
        await authRepository.signInWithSavedCredentials();
    if (response.isRight) {
      userState.user = response.right;
    } else {
      userState.user = null;
    }
    return response;
  }
}
