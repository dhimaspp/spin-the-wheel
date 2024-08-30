import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_controller.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_widget.dart';

class SpinningWheelPage extends StatefulWidget {
  const SpinningWheelPage({super.key});

  @override
  SpinningWheelPageState createState() => SpinningWheelPageState();
}

class SpinningWheelPageState extends State<SpinningWheelPage> {
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  SpinWheelController mySpinController = SpinWheelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Color.fromARGB(255, 31, 65, 132)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinWheelWidget(
                mySpinController: mySpinController,
                wheelSize: MediaQuery.of(context).size.width * 0.4,
                itemList: [
                  SpinItem(
                      label: '0',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      color: const Color(0xff9e00ff),
                      colorName: 'Purple'),
                  SpinItem(
                      label: '10',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      color: const Color(0xffde0000),
                      colorName: 'Red'),
                  SpinItem(
                      label: '20',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      color: const Color(0xff41d849),
                      colorName: 'Green'),
                  SpinItem(
                      label: '25',
                      labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                      color: const Color(0xff00a0ff),
                      colorName: 'Blue'),
                  SpinItem(
                      label: '40',
                      labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
                      color: const Color.fromARGB(255, 255, 234, 0),
                      colorName: 'Yellow'),
                  SpinItem(
                      label: '60',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      color: const Color(0xffff9c00),
                      colorName: 'Orange'),
                  SpinItem(
                      label: '80',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      color: const Color.fromARGB(255, 247, 0, 255),
                      colorName: 'Pink'),
                  SpinItem(
                      label: '100',
                      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
                      color: const Color.fromARGB(255, 0, 225, 255),
                      colorName: 'Cyan'),
                ]),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  int rdm = Random().nextInt(8);
                  await mySpinController.spinNow(
                      luckyIndex: rdm,
                      totalSpin: 6,
                      baseSpinDuration: 30,
                      onFinished: (selectedSpinItem) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Congratulations!"),
                              content: Text(
                                "It's stopped on the ${selectedSpinItem.colorName} color You won ${selectedSpinItem.label} ",
                                style: TextStyle(
                                  color: selectedSpinItem.color,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                },
                child: const Text('Spin Now')),
          ],
        ),
      ),
    );
  }
}
