import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/routes/view_model.dart';
import 'package:doublevpartners/presentation/ui/pages/home/home_page.dart';
import 'package:doublevpartners/presentation/ui/pages/maps/search/map_locations_search_page.dart';
import 'package:doublevpartners/presentation/ui/pages/maps/search/map_locations_search_page_view_model.dart';
import 'package:doublevpartners/presentation/ui/widgets/modals/show_modal.dart';
import 'package:flutter/material.dart';
import 'package:doublevpartners/domain/entities/exception_entity.dart';
import 'package:either_dart/either.dart';

import 'sign_up_page.dart';

class SignUpPageViewModel extends ViewModel<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  Map<String, dynamic> values = {};

  SignUpPageViewModel({
    required super.context,
    required super.widget,
    required super.isMounted,
  });

  void handleSignUp() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      Either<ExceptionEntity, UserEntity> response = await getIt
          .get<SignUpUseCase>()
          .call(
            email: values[KeyWordsLocalization.SignUpPageEmail],
            password: values[KeyWordsLocalization.SignUpPagePassword],
            name: values[KeyWordsLocalization.SignUpPageName],
            birhtday: values[KeyWordsLocalization.SignUpPageBirthDate],
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
}
