import 'package:doublevpartners/data/repositories/auth/auth_repository_dev.dart';
import 'package:doublevpartners/data/repositories/auth/auth_repository_fake.dart';
import 'package:doublevpartners/data/repositories/auth/auth_repository_impl.dart';
import 'package:doublevpartners/data/repositories/localization/localization_repository_impl.dart';
import 'package:doublevpartners/data/repositories/theme/theme_repository_impl.dart';
import 'package:doublevpartners/domain/repositories/auth_repository.dart';
import 'package:doublevpartners/domain/repositories/localization_repository.dart';
import 'package:doublevpartners/domain/repositories/theme_repository.dart';
import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/domain/states/theme/theme_state.dart';
import 'package:doublevpartners/domain/states/user/user_state.dart';
import 'package:doublevpartners/domain/use_cases/auth/get_current_user_use_case.dart';
import 'package:doublevpartners/domain/use_cases/auth/get_saved_email_use_case.dart';
import 'package:doublevpartners/domain/use_cases/auth/sign_in_use_case.dart';
import 'package:doublevpartners/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:doublevpartners/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:doublevpartners/domain/use_cases/auth/verify_finger_print_use_case.dart';
import 'package:doublevpartners/domain/use_cases/localization/change_language_use_case.dart';
import 'package:doublevpartners/domain/use_cases/localization/get_available_languages_use_case.dart';
import 'package:doublevpartners/domain/use_cases/theme/change_theme_mode_use_case.dart';
import 'package:doublevpartners/presentation/provider/language/localization_state_impl.dart';
import 'package:doublevpartners/presentation/provider/theme/theme_provider_impl.dart';
import 'package:doublevpartners/presentation/provider/user/user_state_impl.dart';
import 'package:get_it/get_it.dart';

class DependencyInjection {
  DependencyInjection() {
    GetIt getIt = GetIt.instance;
    //#region ------------- repositories -------------------------//
    // Flavor? mode = F.appFlavor;
    // if (mode == Flavor.fake) {
    //   getIt.registerSingleton<AuthRepository>(AuthRepositoryFake());
    //   getIt.registerSingleton<LocalizationRepository>(
    //     LocalizationRepositoryImpl(),
    //   );
    //   getIt.registerSingleton<ThemeRepository>(ThemeRepositoryImpl());
    // } else if (mode == Flavor.dev) {
    //   getIt.registerSingleton<AuthRepository>(AuthRepositoryDev());
    //   getIt.registerSingleton<LocalizationRepository>(
    //     LocalizationRepositoryImpl(),
    //   );
    //   getIt.registerSingleton<ThemeRepository>(ThemeRepositoryImpl());
    // } else {
    getIt.registerSingleton<AuthRepository>(AuthRepositoryDev());
    getIt.registerSingleton<LocalizationRepository>(
      LocalizationRepositoryImpl(),
    );
    getIt.registerSingleton<ThemeRepository>(ThemeRepositoryImpl());
    // }
    //#endregion repositories

    //#region ------------- providers -------------------------//
    getIt.registerSingleton<UserState>(UserStateImpl());
    getIt.registerSingleton<ThemeState>(ThemeStateImpl());
    getIt.registerSingleton<LocalizationState>(LocalizationStateImpl());
    //#endregion

    //#region ------------- use cases -------------------------//
    //#region ------------- auth -------------------------//
    getIt.registerSingleton<GetCurrentUserUseCase>(
      GetCurrentUserUseCase(
        authRepository: getIt.get<AuthRepository>(),
        userProvider: getIt.get<UserState>(),
      ),
    );
    getIt.registerSingleton<GetSavedEmailUseCase>(
      GetSavedEmailUseCase(authRepository: getIt.get<AuthRepository>()),
    );
    getIt.registerSingleton<SignInUseCase>(
      SignInUseCase(
        authRepository: getIt.get<AuthRepository>(),
        userProvider: getIt.get<UserState>(),
      ),
    );
    getIt.registerSingleton<SignUpUseCase>(
      SignUpUseCase(
        authRepository: getIt.get<AuthRepository>(),
        userState: getIt.get<UserState>(),
      ),
    );
    getIt.registerSingleton<SignOutUseCase>(
      SignOutUseCase(
        authRepository: getIt.get<AuthRepository>(),
        userProvider: getIt.get<UserState>(),
      ),
    );
    getIt.registerSingleton<VerifyFingerPrintUseCase>(
      VerifyFingerPrintUseCase(authRepository: getIt.get<AuthRepository>()),
    );
    //#endregion

    //#region ---------------- default -------------------------//
    getIt.registerSingleton<ChangeThemeModeUseCase>(
      ChangeThemeModeUseCase(
        themeProvider: getIt.get<ThemeState>(),
        themeRepository: getIt.get<ThemeRepository>(),
      ),
    );
    getIt.registerSingleton<GetAvailableLanguagesUseCase>(
      GetAvailableLanguagesUseCase(
        localizationRepository: getIt.get<LocalizationRepository>(),
      ),
    );
    getIt.registerSingleton<ChangeLanguageUseCase>(
      ChangeLanguageUseCase(
        localizationState: getIt.get<LocalizationState>(),
        localizationRepository: getIt.get<LocalizationRepository>(),
      ),
    );
    //#endregion
    //#endregion
  }
}
