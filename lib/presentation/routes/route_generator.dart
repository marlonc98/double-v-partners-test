import 'package:doublevpartners/domain/entities/user/user_entity.dart';
import 'package:doublevpartners/presentation/ui/pages/auth/login/login_page.dart';
import 'package:doublevpartners/presentation/ui/pages/maps/search/map_locations_search_page.dart';
import 'package:doublevpartners/presentation/ui/pages/settings/settings_page.dart';
import 'package:doublevpartners/presentation/ui/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:doublevpartners/presentation/ui/pages/auth/signup/sign_up_page.dart';

Map<String, bool Function(UserEntity? user)> authRoutes = {
  SplashPage.route: (UserEntity? user) => true,
  LoginPage.route: (UserEntity? user) => user == null,
  MapLocationsSearchPage.route: (UserEntity? user) => user != null,
};

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case SplashPage.route:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case LoginPage.route:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case SignUpPage.route:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case MapLocationsSearchPage.route:
        return MaterialPageRoute(builder: (_) => MapLocationsSearchPage());
      case SettingsPage.route:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      default:
        return MaterialPageRoute(builder: (_) => SplashPage());
    }
  }
}
