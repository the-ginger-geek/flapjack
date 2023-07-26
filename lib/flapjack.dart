library flapjack;

import 'package:flutter/material.dart';

export 'src/core/flapjack_view.dart';
export 'src/core/flapjack_view_model.dart';
export 'src/core/flapjack_model.dart';
export 'src/core/flapjack_view_model_widget.dart';
export 'src/core/loader_meta_data.dart';
export 'src/generators/annotations.dart';

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