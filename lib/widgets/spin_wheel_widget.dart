import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_painter.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_controller.dart';

class SpinItem {
  String label;
  TextStyle labelStyle;
  Color color;
  String colorName;

  SpinItem({required this.label, required this.color, required this.colorName, required this.labelStyle});
}

class SpinWheelWidget extends StatefulWidget {
  final SpinWheelController mySpinController;
  final List<SpinItem> itemList;
  final double wheelSize;
  const SpinWheelWidget({
    super.key,
    required this.mySpinController,
    required this.itemList,
    required this.wheelSize,
  });

  @override
  State<SpinWheelWidget> createState() => _SpinWheelWidgetState();
}

class _SpinWheelWidgetState extends State<SpinWheelWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.mySpinController.initLoad(
      tickerProvider: this,
      itemList: widget.itemList,
    );
  }

  @override
  void dispose() {
    super.dispose();
    null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      fit: StackFit.passthrough,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          alignment: Alignment.center,
          child: AnimatedBuilder(
            animation: widget.mySpinController.baseAnimation,
            builder: (context, child) {
              double value = widget.mySpinController.baseAnimation.value;
              double rotationValue = (360 * value);
              return RotationTransition(
                turns: AlwaysStoppedAnimation(rotationValue / 360),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                          width: widget.wheelSize,
                          height: widget.wheelSize,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(5),
                            child: CustomPaint(
                              painter: SpinWheelPainter(items: widget.itemList),
                            ),
                          )),
                    ),
                    ...widget.itemList.map((each) {
                      int index = widget.itemList.indexOf(each);
                      double rotateInterval = 360 / widget.itemList.length;
                      double rotateAmount = (index + 0.5) * rotateInterval;
                      return RotationTransition(
                        turns: AlwaysStoppedAnimation(rotateAmount / 360),
                        child: Transform.translate(
                          offset: Offset(0, -widget.wheelSize / 4),
                          child: RotatedBox(
                            quarterTurns: 3,
                            child: Text(each.label, style: each.labelStyle),
                          ),
                        ),
                      );
                    }),
                    Container(
                      alignment: Alignment.center,
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        hookTrigger()
      ],
    );
  }

  Widget hookTrigger() {
    return AnimatedBuilder(
      animation: widget.mySpinController.baseAnimation,
      builder: (context, child) {
        double rotationValue = widget.mySpinController.getRotationValue();
        double limitedRotation = rotationValue % 30;
        if (limitedRotation > 90 && limitedRotation <= 270) {
          limitedRotation = 90;
        } else if (limitedRotation > 270) {
          limitedRotation = -90;
        }
        return Transform.rotate(
          angle: limitedRotation * math.pi / -180,
          origin: const Offset(-5, 0),
          child: Container(
            padding: const EdgeInsets.all(0),
            child: const Icon(
              Icons.location_on_sharp,
              size: 60,
              color: Color.fromARGB(255, 5, 155, 155),
            ),
          ),
        );
      },
    );
  }
}
