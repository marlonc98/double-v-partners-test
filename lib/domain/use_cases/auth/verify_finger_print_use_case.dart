import 'package:doublevpartners/domain/repositories/auth_repository.dart';

class VerifyFingerPrintUseCase {
  final AuthRepository authRepository;

  VerifyFingerPrintUseCase({required this.authRepository});

  Future<VerifyFingerPrintResponse> call(String text) async {
    return await authRepository.verifyFingerPrint(text);
  }
}
