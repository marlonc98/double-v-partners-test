import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/repositories/auth_repository.dart';
import 'package:doublevpartners/domain/states/user/user_state.dart';

class GetCurrentUserUseCase {
  final AuthRepository authRepository;
  final UserState userProvider;

  GetCurrentUserUseCase({
    required this.authRepository,
    required this.userProvider,
  });

  Future<UserEntity?> call() async {
    UserEntity? response = await authRepository.getUser();
    userProvider.user = response;
    return response;
  }
}
