library flapjack;

import 'package:flutter/material.dart';

import 'src/view_model_locator.dart';
export 'src/flapjack_view.dart';
export 'src/flapjack_view_model.dart';
export 'src/flapjack_model.dart';

class Flapjack extends InheritedWidget {

  final ViewModelLocator locator = ViewModelLocator();

  Flapjack({super.key, required super.child});

  static Flapjack? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Flapjack>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}