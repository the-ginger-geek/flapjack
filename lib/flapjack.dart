library flapjack;

import 'package:flutter/material.dart';

export 'src/flapjack_view.dart';
export 'src/flapjack_view_model.dart';
export 'src/flapjack_model.dart';
export 'src/flapjack_view_model_widget.dart';

class Flapjack extends InheritedWidget {

  const Flapjack({super.key, required super.child});

  static Flapjack? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Flapjack>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}