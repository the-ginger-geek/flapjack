import 'package:flutter/material.dart';

import 'flapjack_model.dart';
import 'view_model_locator.dart';

abstract class FlapjackViewModel<T extends FlapjackModel> extends ChangeNotifier {
  final T model;
  
  ViewModelLocator? locator;

  FlapjackViewModel(this.model);

  void registerViewModelLocator(ViewModelLocator? locator) {
    this.locator = locator;
    locator?.register(runtimeType, this);
  }

  @override
  void dispose() {
    locator?.unregister(runtimeType, this);
    super.dispose();
  }

  VM? findRelative<VM>() {
    return locator?.get<VM>();
  }
}