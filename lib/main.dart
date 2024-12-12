import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reprex/color_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExampleBody(),
    );
  }
}

class ExampleBody extends StatefulWidget {
  const ExampleBody({super.key});

  @override
  State<ExampleBody> createState() => _ExampleBodyState();
}

class _ExampleBodyState extends State<ExampleBody> {
  final List<ColorClass> namedColors = [
    const ColorClass(name: 'Yellow', color: Colors.yellow),
    const ColorClass(name: 'Red', color: Colors.red),
    const ColorClass(name: 'Green', color: Colors.green),
    const ColorClass(name: 'Blue', color: Colors.blue),
    const ColorClass(name: 'Indigo', color: Colors.indigo),
    const ColorClass(name: 'purple', color: Colors.purple),
  ];

  final ValueNotifier<ColorClass> colorNotifier =
      ValueNotifier(const ColorClass(name: 'Blue', color: Colors.blue));

  void setRandomColor() {
    final int colorIndex = Random().nextInt(6);
    colorNotifier.value = namedColors[colorIndex];
    print(colorNotifier.value);
  }

  @override
  void dispose() {
    colorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 200),
            ValueListenableBuilder(
              valueListenable: colorNotifier,
              builder:
                  (BuildContext context, ColorClass colorObj, Widget? child) {
                return Container(
                  height: 200,
                  width: 200,
                  color: colorObj.color,
                  child: Center(child: Text(colorObj.name)),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: setRandomColor,
              child: Text('Change color'),
            ),
          ],
        ),
      ),
    );
  }
}
