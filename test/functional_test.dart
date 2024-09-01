import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spin_the_wheel/screens/spin_wheel_view.dart';

void main() {
  testWidgets('Spinner stops on the correct item and shows the correct dialog message', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: SpinningWheelPage(),
      ),
    );

    // Act
    // Tap the spin button
    await tester.tap(find.text('Spin Now'));
    await tester.pump(); // Trigger a frame to process the tap

    // Simulate the time for the spin to complete
    await tester.pumpAndSettle();

    // Assert
    // Check if the dialog appears
    expect(find.byType(AlertDialog), findsOneWidget);

    // Check the title of the dialog
    expect(find.text('Congratulations!'), findsOneWidget);

    // Verify dialog content text includes some expected values
    expect(find.textContaining("It's stopped on the"), findsOneWidget);
    expect(find.textContaining('You won'), findsOneWidget);

    // Dismiss the dialog
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify the dialog is dismissed
    expect(find.byType(AlertDialog), findsNothing);
  });
}
