library flapjack;

import 'package:flutter/material.dart';

export 'src/flapjack_view.dart';
export 'src/flapjack_view_model.dart';
export 'src/flapjack_model.dart';

class Flapjack extends InheritedWidget {

  const Flapjack({super.key, required super.child});

  static Flapjack? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Flapjack>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}