import 'package:flutter/material.dart';

import 'flapjack_model.dart';

abstract class FlapjackViewModel<T extends FlapjackModel> extends ChangeNotifier {
  final T model;

  FlapjackViewModel(this.model);
}