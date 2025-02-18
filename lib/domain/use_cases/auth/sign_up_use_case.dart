import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/repositories/auth_repository.dart';
import 'package:doublevpartners/domain/states/user/user_state.dart';
import 'package:either_dart/either.dart';

class SignUpUseCase {
  final AuthRepository authRepository;
  final UserState userState;

  SignUpUseCase({required this.authRepository, required this.userState});

  Future<Either<ExceptionEntity, UserEntity>> call({
    required String email,
    required String password,
    required String name,
    required DateTime birhtday,
  }) async {
    final user = await authRepository.signUp(
      email: email,
      password: password,
      name: name,
      birhtday: birhtday,
    );
    if (user.isRight) {
      userState.user = user.right;
    }
    return user;
  }
}
