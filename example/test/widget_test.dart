import 'package:flutter_test/flutter_test.dart';
import 'package:flapjack/flapjack.dart';
import 'package:flutter/material.dart';
import 'package:managing_state/main.dart';

void main() {
  group('Flapjack tests', () {
    test('ViewModelLocator registers and retrieves ViewModel', () {
      final locator = ViewModelLocator();
      final testViewModel = HomeViewModel(HomeModel());

      locator.register(HomeViewModel, testViewModel);

      expect(locator.get<HomeViewModel>(), equals(testViewModel));
    });

    test('ViewModelLocator throws exception for unregistered ViewModel', () {
      final locator = ViewModelLocator();

      expect(() => locator.get<HomeViewModel>(), throwsException);
    });

    test('ViewModelLocator unregisters ViewModel', () {
      final locator = ViewModelLocator();
      final testViewModel = HomeViewModel(HomeModel());

      locator.register(HomeViewModel, testViewModel);
      locator.unregister(HomeViewModel, testViewModel);

      expect(() => locator.get<HomeViewModel>(), throwsException);
    });

    test('HomeViewModel increments counter', () {
      final model = HomeModel();
      final viewModel = HomeViewModel(model);

      viewModel.increment();

      expect(viewModel.counter, equals(1));
    });

    testWidgets('OtherButton increments HomeViewModel counter',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        Flapjack(
          child: const MaterialApp(
            home: Home(title: 'Test Home'),
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton).at(0));

      await tester.pumpAndSettle();

      expect(find.text('1'), findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton).at(1));

      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
    });
  });
}
