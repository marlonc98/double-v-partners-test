import 'package:doublevpartners/constants.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/ui/pages/auth/login/login_page.dart';
import 'package:doublevpartners/presentation/ui/pages/auth/signup/sign_up_page_view_model.dart';
import 'package:doublevpartners/presentation/ui/widgets/buttons/button_widget.dart';
import 'package:doublevpartners/presentation/ui/widgets/form/form_generator_widget.dart';
import 'package:doublevpartners/presentation/ui/widgets/form/form_widget.dart';
import 'package:doublevpartners/presentation/ui/widgets/image_network_with_load_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  static const String route = '/auth/signup';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpPageViewModel>(
      create:
          (_) => SignUpPageViewModel(
            context: context,
            widget: widget,
            isMounted: () => mounted,
          ),
      child: Consumer<SignUpPageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    //circle img
                    ImageNetworkWithLoadWidget(
                      IMG_LOGO_CIRCLE,
                      fit: BoxFit.contain,
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(height: 16),
                    Text(
                      viewModel.localization.translate(
                        KeyWordsLocalization.SignUpPageTitle,
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      viewModel.localization.translate(
                        KeyWordsLocalization.SignUpPageDescription,
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 32),
                    Form(
                      key: viewModel.formKey,
                      child: FormGeneratorWidget(
                        values: viewModel.values,
                        formWidgets: [
                          FormWidget(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            text: viewModel.localization.translate(
                              KeyWordsLocalization.SignUpPageName,
                            ),
                            keyName: KeyWordsLocalization.SignUpPageName,
                            required: true,
                            values: viewModel.values,
                            type: FormType.text,
                          ),
                          FormWidget(
                            prefixIcon: Icon(
                              Icons.cake_outlined,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            text: viewModel.localization.translate(
                              KeyWordsLocalization.SignUpPageBirthDate,
                            ),
                            keyName: KeyWordsLocalization.SignUpPageBirthDate,
                            required: true,
                            values: viewModel.values,
                            type: FormType.date,
                          ),
                          FormWidget(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            text: viewModel.localization.translate(
                              KeyWordsLocalization.SignUpPageEmail,
                            ),
                            keyName: KeyWordsLocalization.SignUpPageEmail,
                            required: true,
                            values: viewModel.values,
                            type: FormType.email,
                          ),
                          FormWidget(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            text: viewModel.localization.translate(
                              KeyWordsLocalization.SignUpPagePassword,
                            ),
                            keyName: KeyWordsLocalization.SignUpPagePassword,
                            values: viewModel.values,
                            minLength: 6,
                            required: true,
                            type: FormType.password,
                          ),
                          FormWidget(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            text: viewModel.localization.translate(
                              KeyWordsLocalization.SignUpPageConfirmPassword,
                            ),
                            keyName:
                                KeyWordsLocalization.SignUpPageConfirmPassword,
                            values: viewModel.values,
                            minLength: 6,
                            required: true,
                            type: FormType.password,
                            matchFieldKey:
                                KeyWordsLocalization.SignUpPagePassword,
                            matchFieldName: viewModel.localization.translate(
                              KeyWordsLocalization.SignUpPagePassword,
                            ),
                            onFieldSubmitted: (_) => viewModel.handleSignUp(),
                          ),
                        ],
                        onSubmit: viewModel.handleSignUp,
                      ),
                    ),
                    SizedBox(height: 10),
                    ButtonWidget(
                      active: !viewModel.loading,
                      width: MediaQuery.of(context).size.width * .5,
                      onTap: viewModel.handleSignUp,
                      text: viewModel.localization.translate(
                        KeyWordsLocalization.SignUpPageSignUp,
                      ),
                      type: TypeButton.Main,
                    ),
                    SizedBox(height: 50),
                    ButtonWidget(
                      onTap:
                          () => Navigator.of(
                            context,
                          ).popAndPushNamed(LoginPage.route),
                      text: viewModel.localization.translate(
                        KeyWordsLocalization.SignUpPageLogin,
                      ),
                      type: TypeButton.NotLineMain,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
