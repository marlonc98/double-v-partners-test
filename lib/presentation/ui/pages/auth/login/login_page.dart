import 'package:doublevpartners/constants.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/ui/pages/auth/login/login_page_view_model.dart';
import 'package:doublevpartners/presentation/ui/pages/auth/signup/sign_up_page.dart';
import 'package:doublevpartners/presentation/ui/widgets/buttons/button_widget.dart';
import 'package:doublevpartners/presentation/ui/widgets/form/form_generator_widget.dart';
import 'package:doublevpartners/presentation/ui/widgets/form/form_widget.dart';
import 'package:doublevpartners/presentation/ui/widgets/image_network_with_load_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/auth/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageViewModel>(
      create:
          (_) => LoginPageViewModel(
            context: context,
            widget: widget,
            isMounted: () => mounted,
          ),
      child: Consumer<LoginPageViewModel>(
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
                        KeyWordsLocalization.LoginPageTitle,
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
                        KeyWordsLocalization.LoginPageDescription,
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
                              Icons.email_outlined,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            text: viewModel.localization.translate(
                              KeyWordsLocalization.LoginPageEmail,
                            ),
                            keyName: KeyWordsLocalization.LoginPageEmail,
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
                              KeyWordsLocalization.LoginPagePassword,
                            ),
                            keyName: KeyWordsLocalization.LoginPagePassword,
                            values: viewModel.values,
                            required: true,
                            type: FormType.password,
                            onFieldSubmitted: (_) => viewModel.handleLogin(),
                          ),
                        ],
                        onSubmit: viewModel.handleLogin,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (viewModel.isFingerprintAvailable)
                          SizedBox(width: 30),
                        ButtonWidget(
                          active: !viewModel.loading,
                          width: MediaQuery.of(context).size.width * .5,
                          onTap: viewModel.handleLogin,
                          text: viewModel.localization.translate(
                            KeyWordsLocalization.LoginPageLogin,
                          ),
                          type: TypeButton.Main,
                        ),
                        if (viewModel.isFingerprintAvailable)
                          SizedBox(width: 10),
                        if (viewModel.isFingerprintAvailable)
                          IconButton(
                            onPressed: viewModel.handleLoginWithFingerprint,
                            icon: Icon(
                              Icons.fingerprint,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 50),
                    ButtonWidget(
                      onTap:
                          () => Navigator.of(
                            context,
                          ).popAndPushNamed(SignUpPage.route),
                      text: viewModel.localization.translate(
                        KeyWordsLocalization.LoginPageSignUp,
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
