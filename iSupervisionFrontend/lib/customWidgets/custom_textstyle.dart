import 'package:flutter/material.dart';

class CustomTextStyles {
  CustomTextStyles();

  static TextStyle standardText() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 16,
    );
  }

  static TextStyle headerText() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle errorText() {
    return const TextStyle(
      color: Colors.red,
      fontSize: 16,
    );
  }
}
