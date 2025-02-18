import 'package:flutter/material.dart';

class OptionsHomeRoute {
  String route;
  String keyname;
  IconData? icon;
  List<String> auths;
  OptionsHomeRoute(
      {required this.route,
      required this.keyname,
      this.icon,
      required this.auths});
}
