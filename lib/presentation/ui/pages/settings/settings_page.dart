import 'package:doublevpartners/domain/states/user/user_state.dart';
import 'package:doublevpartners/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:doublevpartners/presentation/ui/pages/auth/login/login_page.dart';
import 'package:doublevpartners/presentation/ui/widgets/custom_bottom_navigation.dart';
import 'package:doublevpartners/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const String route = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context).user;
    final iconColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, size: 20, color: iconColor),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            user!.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.email, size: 16, color: iconColor),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            user.email,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, size: 16, color: iconColor),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            DatesFormat.getDayMonthAndYear(
                              user.birthday,
                              context,
                            ),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  GetIt.I.get<SignOutUseCase>().call();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginPage.route,
                    (route) => false,
                  );
                },
                child: Text('Logout', style: TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        context: context,
        currentRoute: SettingsPage.route,
      ),
    );
  }
}
