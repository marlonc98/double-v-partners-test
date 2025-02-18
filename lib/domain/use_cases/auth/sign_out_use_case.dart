import 'package:doublevpartners/domain/states/user/user_state.dart';

import '../../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;
  final UserState userProvider;

  SignOutUseCase({required this.authRepository, required this.userProvider});

  Future<void> call() async {
    await authRepository.logout();
    userProvider.user = null;
  }
}
