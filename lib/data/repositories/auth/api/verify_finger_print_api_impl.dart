import 'package:doublevpartners/domain/repositories/auth_repository.dart';
import 'package:local_auth/local_auth.dart';

Future<VerifyFingerPrintResponse> verifyFingerPrintApiImpl(String text) async {
  LocalAuthentication _auth = LocalAuthentication();
  try {
    final isAvailable = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    List<BiometricType> availableBiometrics =
        await _auth.getAvailableBiometrics();
    if (!isAvailable || !isDeviceSupported) {
      return VerifyFingerPrintResponse.unavailable;
    }
    if (availableBiometrics.isNotEmpty) {
      bool canLogin = await _auth.authenticate(localizedReason: text);
      if (canLogin) {
        return VerifyFingerPrintResponse.success;
      } else {
        return VerifyFingerPrintResponse.fail;
      }
    } else {
      _auth.stopAuthentication();
      return VerifyFingerPrintResponse.fail;
    }
  } catch (_) {
    _auth.stopAuthentication();
    return VerifyFingerPrintResponse.fail;
  }
}
