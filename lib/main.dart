import 'package:flutter/material.dart';
import 'package:spin_the_wheel/screens/spin_wheel_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SpinningWheelPage(),
      ),
    );
  }
}
