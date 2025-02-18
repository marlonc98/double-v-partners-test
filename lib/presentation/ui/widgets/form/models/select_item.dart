import 'package:flutter/material.dart';

class SelectItem<T> {
  String? aditionalValue;
  String text;
  T value;
  VoidCallback? onTap;
  Widget? child;

  SelectItem(
      {required this.text,
      this.aditionalValue,
      required this.value,
      this.onTap,
      this.child});

  @override
  String toString() {
    return "SelectItem: (text: $text, value: $value, aditionalValue: $aditionalValue)";
  }
}
