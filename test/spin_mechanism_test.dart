import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_controller.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_widget.dart';

class MockSpinItem extends Mock implements SpinItem {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize the binding

  group('Spin Mechanism', () {
    late SpinWheelController spinWheelController;
    late List<SpinItem> itemList;
    late SpinItem selectedItem;

    setUp(() {
      spinWheelController = SpinWheelController();
      itemList = [
        SpinItem(label: '10', labelStyle: const TextStyle(), color: Colors.red, colorName: 'Red'),
        SpinItem(label: '20', labelStyle: const TextStyle(), color: Colors.green, colorName: 'Green'),
        SpinItem(label: '60', labelStyle: const TextStyle(), color: Colors.blue, colorName: 'Orange'),
      ];
      selectedItem = itemList[1];
    });

    test('spinNow triggers onFinished with the correct item', () async {
      await spinWheelController.initLoad(
        tickerProvider: const TestVSync(),
        itemList: itemList,
      );

      spinWheelController.spinNow(
        luckyIndex: 1,
        baseSpinDuration: 1,
        totalSpin: 1,
        onFinished: (SpinItem result) {
          expect(result.label, selectedItem.label);
        },
      );
    });
  });
}
