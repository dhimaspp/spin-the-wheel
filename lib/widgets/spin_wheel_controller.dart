import 'package:flutter/material.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_widget.dart';

class SpinWheelController {
  late AnimationController baseAnimation;
  late TickerProvider _tickerProvider;
  late double targetHook;
  bool _xSpinning = false;
  List<SpinItem> _itemList = [];

  Future<void> initLoad({
    required TickerProvider tickerProvider,
    required List<SpinItem> itemList,
  }) async {
    _tickerProvider = tickerProvider;
    _itemList = itemList;
    await setAnimations(_tickerProvider);
  }

  Future<void> setAnimations(TickerProvider tickerProvider) async {
    baseAnimation = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 200),
    );
  }

  Future<void> spinNow(
      {required int luckyIndex,
      int totalSpin = 5,
      int baseSpinDuration = 100,
      required Function(SpinItem) onFinished}) async {
    //getWhereToStop
    int itemsLength = _itemList.length;
    int factor = luckyIndex % itemsLength;
    if (factor == 0) factor = itemsLength;
    double spinInterval = 1 / itemsLength;
    double target = 1 - ((spinInterval * factor) - (spinInterval / 2));

    if (!_xSpinning) {
      _xSpinning = true;
      int spinCount = 0;

      do {
        baseAnimation.reset();
        baseAnimation.duration = Duration(milliseconds: baseSpinDuration);
        if (spinCount == totalSpin) {
          targetHook = target;
          await baseAnimation.animateTo(target);
        } else {
          await baseAnimation.forward();
        }
        baseSpinDuration = baseSpinDuration + 500;
        baseAnimation.duration = Duration(milliseconds: baseSpinDuration);
        spinCount++;
      } while (spinCount <= totalSpin);

      onFinished(_itemList[factor - 1]);

      _xSpinning = false;
    }
  }

  double getRotationValue() {
    return baseAnimation.value * 180;
  }
}
