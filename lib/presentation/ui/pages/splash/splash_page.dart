import 'package:doublevpartners/constants.dart';
import 'package:doublevpartners/domain/states/localization/localization_state.dart';
import 'package:doublevpartners/presentation/provider/language/key_word_localization.dart';
import 'package:doublevpartners/presentation/ui/pages/auth/login/login_page.dart';
import 'package:doublevpartners/presentation/ui/widgets/image_network_with_load_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  static const String route = '/settings/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  PackageInfo? packageInfo;

  Future<void> loadVersionAndBuildNumber() async {
    packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> initApp() async {
    await Future.delayed(Duration(milliseconds: 300));
    if (mounted) {
      Navigator.of(
        // ignore: use_build_context_synchronously
        context,
      ).pushNamedAndRemoveUntil(LoginPage.route, (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      initApp();
      loadVersionAndBuildNumber();
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationState>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageNetworkWithLoadWidget(IMG_LOGO_CIRCLE, height: 200),
                  SizedBox(height: 16),
                  Text(
                    "Secret Location's APP",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              localization.translate(KeyWordsLocalization.DevelopedBy),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          if (packageInfo != null)
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: Text(
                localization.translate(
                  KeyWordsLocalization.VersionAndBuild,
                  values: {
                    "version": packageInfo!.version,
                    "build": packageInfo!.buildNumber,
                  },
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
