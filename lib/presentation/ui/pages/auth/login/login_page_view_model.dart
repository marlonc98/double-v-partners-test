import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/use_cases/auth/get_saved_email_use_case.dart';
import 'package:doublevpartners/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:doublevpartners/domain/use_cases/auth/sign_in_with_finger_print_use_case.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/routes/view_model.dart';
import 'package:doublevpartners/presentation/ui/pages/home/home_page.dart';
import 'package:doublevpartners/presentation/ui/pages/maps/search/map_locations_search_page.dart';
import 'package:doublevpartners/presentation/ui/widgets/modals/show_modal.dart';
import 'package:flutter/material.dart';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:either_dart/either.dart';
import 'package:local_auth/local_auth.dart';

import 'login_page.dart';

class LoginPageViewModel extends ViewModel<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isFingerprintAvailable = false;

  Map<String, dynamic> values = {
    KeyWordsLocalization.LoginPageRememberMe: [true],
  };
  LoginPageViewModel({
    required super.context,
    required super.widget,
    required super.isMounted,
  }) {
    _loadEmailAndFinger();
  }

  void _loadEmailAndFinger() async {
    final results = await Future.wait([
      _validateFingerPrint(),
      _loadSavedEmail(),
    ]);

    bool isValidFinger = results[0] as bool;
    bool isSaved = (results[1] as String?) != null;

    if (mounted) {
      isFingerprintAvailable = isValidFinger && isSaved;
      notifyListeners();
    }
  }

  Future<bool> _validateFingerPrint() async {
    LocalAuthentication _auth = LocalAuthentication();
    final isAvailable = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    if (!isAvailable || !isDeviceSupported) {
      return false;
    }
    return true;
  }

  Future<String?> _loadSavedEmail() async {
    String? email = await getIt.get<GetSavedEmailUseCase>().call();
    if (email != null && mounted) {
      values[KeyWordsLocalization.LoginPageEmail] = email;
      notifyListeners();
    }
    return email;
  }

  void handleLogin() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      Either<ExceptionEntity, UserEntity> response = await getIt
          .get<SignInUseCase>()
          .call(
            values[KeyWordsLocalization.LoginPageEmail],
            values[KeyWordsLocalization.LoginPagePassword],
          );
      if (response.isRight) {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MapLocationsSearchPage.route,
            (route) => false,
          );
        }
      } else {
        loading = false;
        notifyListeners();
        if (mounted) {
          ShowModal.showSnackBar(
            // ignore: use_build_context_synchronously
            context: context,
            text: localization.translate(response.left.code),
            error: true,
          );
        }
      }
    }
  }

  void handleLoginWithFingerprint() async {
    loading = true;
    notifyListeners();
    Either<ExceptionEntity, UserEntity> response =
        await getIt.get<SignInWithFingerPrintUseCase>().call();
    if (response.isRight) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          // ignore: use_build_context_synchronously
          context,
          HomePage.route,
          (route) => false,
        );
      }
      return;
    } else if (response.left.code !=
        KeyWordsLocalization.LocalAuthUnavailable) {
      loading = false;
      notifyListeners();
      if (mounted) {
        ShowModal.showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          text: localization.translate(response.left.code),
          error: true,
        );
      }
    }
  }
}
