import 'package:flutter/material.dart';

class ColorClass {
  final String name;
  final Color color;

  const ColorClass({required this.name, required this.color});

  @override
  String toString() {
    return '{name: $name, color: $color}';
  }
}
