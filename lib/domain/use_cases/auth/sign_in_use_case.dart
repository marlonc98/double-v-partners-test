import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/states/user/user_state.dart';
import 'package:either_dart/either.dart';
import '../../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;
  final UserState userProvider;

  SignInUseCase({required this.authRepository, required this.userProvider});

  Future<Either<ExceptionEntity, UserEntity>> call(
    String email,
    String password,
  ) async {
    Either<ExceptionEntity, UserEntity> response = await authRepository.login(
      email,
      password,
    );
    if (response.isRight) {
      userProvider.user = response.right;
    } else {
      userProvider.user = null;
    }
    return response;
  }
}
