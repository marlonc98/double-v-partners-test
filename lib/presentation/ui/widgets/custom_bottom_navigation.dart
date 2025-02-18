import 'package:doublevpartners/domain/states/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doublevpartners/presentation/ui/pages/settings/settings_page.dart';
import 'package:doublevpartners/presentation/ui/pages/maps/search/map_locations_search_page.dart';

class CustomBottomNavigation extends StatelessWidget {
  final String? currentRoute;
  final BuildContext context;

  CustomBottomNavigation({super.key, this.currentRoute, required this.context});

  late UserState userState;

  final List<RouteHome> routes = [
    RouteHome(
      route: MapLocationsSearchPage.route,
      icon: Icons.location_on,
      label: 'Locations',
    ),
    RouteHome(
      route: SettingsPage.route,
      icon: Icons.settings,
      label: 'Settings',
    ),
  ];

  int? getIndex() {
    if (currentRoute == null) return null;
    return routes.indexWhere((route) => route.route == currentRoute);
  }

  @override
  Widget build(BuildContext context) {
    userState = Provider.of<UserState>(context);
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
      elevation: 16,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index != getIndex()) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            routes[index].route,
            (route) => false,
          );
        }
      },
      currentIndex: getIndex() ?? 0,
      selectedLabelStyle: TextStyle(
        color:
            getIndex() == null ? Colors.grey : (Theme.of(context).primaryColor),
      ),
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      selectedItemColor:
          getIndex() == null ? Colors.grey : (Theme.of(context).primaryColor),
      items:
          routes
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(e.icon, size: 25),
                  label: e.label,
                ),
              )
              .toList(),
    );
  }
}

class RouteHome {
  final String route;
  final IconData icon;
  final String label;

  RouteHome({required this.route, required this.icon, required this.label});
}
