import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: ExampleBody(),
      ),
    );
  }
}

class ExampleBody extends StatelessWidget {
  ExampleBody({super.key});

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EditableText(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(),
        cursorColor: Colors.black,
        backgroundCursorColor: Colors.black,
      ),
    );
  }
}
