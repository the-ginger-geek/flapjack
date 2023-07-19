import 'package:flutter/material.dart';
import 'flapjack_view_model.dart';

/// A widget that efficiently provides an instance of [FlapjackViewModel]
/// to its descendants, allowing them to access and react to its changes.
///
/// [FlapjackViewModelProvider] leverages the [InheritedWidget] mechanism
/// in Flutter to expose a [FlapjackViewModel] instance to the widget tree.
/// This enables child widgets to read the model without explicitly passing
/// it around through constructors.
///
/// Typical usage is as a parent widget:
///
/// ```
/// FlapjackViewModelProvider<MyViewModel>(
///   viewModel: myViewModelInstance,
///   child: SomeChildWidget(),
/// );
/// ```
///
/// And then within `SomeChildWidget` or any of its descendants, you can obtain the model by:
///
/// ```
/// final viewModel = FlapjackViewModelProvider.of<MyViewModel>(context);
/// ```
class FlapjackViewModelProvider<M extends FlapjackViewModel> extends InheritedWidget {
  /// The [FlapjackViewModel] instance that this provider holds.
  final M viewModel;

  /// Creates a [FlapjackViewModelProvider].
  ///
  /// Takes in the [viewModel] to be provided and the [child] widget
  /// which will have access to the provided [viewModel].
  const FlapjackViewModelProvider({Key? key, required this.viewModel, required Widget child})
      : super(key: key, child: child);

  /// Retrieves the [FlapjackViewModel] of the specified type [M]
  /// from the nearest ancestor [FlapjackViewModelProvider] in the widget tree.
  ///
  /// Throws a [FlutterError] if no appropriate [FlapjackViewModelProvider] is found.
  static FlapjackViewModel of<M extends FlapjackViewModel>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<FlapjackViewModelProvider<M>>();
    if (provider == null) throw FlutterError('No FlapjackViewModelProvider found in context');
    return provider.viewModel;
  }

  /// Determines if the widget should be rebuilt when the widget tree gets updated.
  ///
  /// This widget rebuilds when there's a new instance of the [FlapjackViewModel].
  @override
  bool updateShouldNotify(FlapjackViewModelProvider oldWidget) {
    return viewModel != oldWidget.viewModel;
  }
}
