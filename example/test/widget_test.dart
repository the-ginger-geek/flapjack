import 'package:flutter_test/flutter_test.dart';
import 'package:flapjack/flapjack.dart';
import 'package:flutter/material.dart';
import 'package:managing_state/home_view.dart';
import 'package:managing_state/home_view_model.dart';

void main() {
  group('Flapjack tests', () {
    test('HomeViewModel increments counter', () async {
      final model = HomeModel();
      final viewModel = HomeViewModel(model);

      await viewModel.incrementFuture(2);

      expect(viewModel.model.counter, equals(2));
    });

    testWidgets('OtherButton increments HomeViewModel counter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const Flapjack(
          child: MaterialApp(
            home: Home(title: 'Test Home'),
          ),
        ),
      );

      // increment button
      await tester.tap(find.byType(FloatingActionButton).at(1));

      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(find.text('2'), findsOneWidget);

      // decrement button
      await tester.tap(find.byType(FloatingActionButton).at(0));

      await tester.pumpAndSettle(const Duration(milliseconds: 360));

      expect(find.text('0'), findsOneWidget);
    });
  });
}
