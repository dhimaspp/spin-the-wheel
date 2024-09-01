import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_controller.dart';
import 'package:spin_the_wheel/widgets/spin_wheel_widget.dart';
import 'dart:math' as math;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Initialize the binding

  group('Hook Trigger', () {
    late SpinWheelController spinWheelController;
    late List<SpinItem> itemList;

    setUp(() {
      spinWheelController = SpinWheelController();
      itemList = [
        SpinItem(label: '10', labelStyle: const TextStyle(), color: Colors.red, colorName: 'Red'),
        SpinItem(label: '20', labelStyle: const TextStyle(), color: Colors.green, colorName: 'Green'),
        SpinItem(label: '60', labelStyle: const TextStyle(), color: Colors.blue, colorName: 'Orange'),
      ];
    });

    testWidgets('hookTrigger limits rotation correctly', (WidgetTester tester) async {
      // Initialize the widget with the controller and item list
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SpinWheelWidget(
            mySpinController: spinWheelController,
            itemList: itemList,
            wheelSize: 300.0,
          ),
        ),
      ));

      // Set up a range of rotation values to test
      final List<double> rotationValues = [0, 90, 180, 270, 360, 450, 540];

      for (var rotationValue in rotationValues) {
        // Manually set the rotation value in the controller
        spinWheelController.baseAnimation.value = rotationValue / 360;

        // Rebuild the widget with the new rotation value
        await tester.pumpAndSettle();

        // Verify that the hook rotation is within the expected limits
        final Finder hookIconFinder = find.byIcon(Icons.location_on_sharp);
        expect(hookIconFinder, findsOneWidget);

        // Find the Transform widget that wraps the Icon
        final Finder transformFinder = find.ancestor(
          of: hookIconFinder,
          matching: find.byType(Transform),
        );
        expect(transformFinder, findsOneWidget);

        final Transform transform = tester.widget<Transform>(transformFinder);
        final double actualRotation = transform.transform.getRotationAngle();

        final double expectedRotation = _getExpectedLimitedRotation(rotationValue);

        // Allow a slightly larger margin of error to account for floating-point inaccuracies
        expect(actualRotation, closeTo(expectedRotation, 0.3),
            reason: 'Expected hook rotation at $expectedRotation radians, but got $actualRotation radians');
      }
    });
  });
}

/// Helper method to calculate the expected limited rotation
double _getExpectedLimitedRotation(double rotationValue) {
  double limitedRotation = rotationValue % 360;

  if (limitedRotation > 90 && limitedRotation <= 270) {
    limitedRotation = 90;
  } else if (limitedRotation > 270) {
    limitedRotation = -90;
  }
  return 0.0; // Default no rotation
}

/// Extension method to get the rotation angle from a 4x4 matrix
extension on Matrix4 {
  double getRotationAngle() {
    final double sinTheta = this[1];
    final double cosTheta = this[0];
    return math.atan2(sinTheta, cosTheta);
  }
}
