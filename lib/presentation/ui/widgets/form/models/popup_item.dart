import 'package:flutter/material.dart';

class PopupItem {
  String text;
  IconData? icon;
  VoidCallback onTap;
  bool active;

  PopupItem(
      {required this.text, this.icon, required this.onTap, this.active = true});
}
