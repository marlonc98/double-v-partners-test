import 'package:doublevpartners/dependency_injection.dart';
import 'package:doublevpartners/domain/states/theme/theme_state.dart';
import 'package:doublevpartners/presentation/provider/theme/themes.dart';
import 'package:doublevpartners/presentation/routes/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'domain/states/localization/localization_state.dart';
import 'domain/states/user/user_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeState>(
          create: (_) => GetIt.instance.get<ThemeState>(),
        ),
        ChangeNotifierProvider<LocalizationState>(
          create: (_) => GetIt.instance.get<LocalizationState>(),
        ),
        ChangeNotifierProvider<UserState>(
          create: (_) => GetIt.instance.get<UserState>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeState>(context).themeMode,
    );
  }
}
