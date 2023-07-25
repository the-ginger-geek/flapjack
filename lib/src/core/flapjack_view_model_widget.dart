import 'package:flapjack/flapjack.dart';
import 'package:flutter/material.dart';

import 'flapjack_view_model_provider.dart';

/// An abstract widget that provides a structure for associating [FlapjackViewModel]
/// with its respective view in the Flapjack architecture.
abstract class FlapjackViewModelWidget<T extends FlapjackViewModel> extends Widget {

  /// Constructs a [FlapjackViewModelWidget].
  const FlapjackViewModelWidget({Key? key}) : super(key: key, );

  /// This method defines the UI that is associated with the [FlapjackViewModel].
  ///
  /// Override this method in subclasses to provide the actual widget tree.
  @protected
  Widget build(BuildContext context, T viewModel);

  @override
  DataProviderElement<T> createElement() => DataProviderElement<T>(this);
}

/// A specialized [ComponentElement] that is designed to work with the [FlapjackViewModelWidget].
///
/// It helps in bridging the view (widget tree) and the [FlapjackViewModel] in the Flapjack architecture.
class DataProviderElement<T extends FlapjackViewModel> extends ComponentElement {
  /// Constructs a [DataProviderElement] with the given [FlapjackViewModelWidget].
  DataProviderElement(FlapjackViewModelWidget widget) : super(widget);

  @override
  FlapjackViewModelWidget get widget => super.widget as FlapjackViewModelWidget;

  /// Builds the widget using the associated [FlapjackViewModel] obtained from
  /// the [FlapjackViewModelProvider].
  @override
  Widget build() =>
      widget.build(this, FlapjackViewModelProvider.of<T>(this));

  /// Updates the widget and forces a rebuild if there's a new version of the widget.
  @override
  void update(FlapjackViewModelWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    rebuild(force: true);
  }
}
