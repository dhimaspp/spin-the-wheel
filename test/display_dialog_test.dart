import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spin_the_wheel/screens/spin_wheel_view.dart';

void main() {
  testWidgets('Displays congratulatory dialog after spin', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: SpinningWheelPage(),
      ),
    );

    // Act
    // Tap the spin button
    await tester.tap(find.text('Spin Now'));

    // Wait for the spin to complete
    await tester.pumpAndSettle();

    // Assert
    // Check if the dialog appears
    expect(find.byType(AlertDialog), findsOneWidget);

    // Check the title of the dialog
    expect(find.text('Congratulations!'), findsOneWidget);

    // Check if the content text appears (sample check for any color and label, for example, "Yellow" and "40")
    expect(find.textContaining("It's stopped on the"), findsOneWidget);
    expect(find.textContaining('You won'), findsOneWidget);

    // Dismiss the dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify the dialog is dismissed
    expect(find.byType(AlertDialog), findsNothing);
  });
}
