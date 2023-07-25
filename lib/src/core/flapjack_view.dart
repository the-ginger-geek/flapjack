import 'package:flutter/material.dart';
import '../../flapjack.dart';
import 'flapjack_view_model_provider.dart';

/// An abstract [StatefulWidget] that provides a base structure for linking a view
/// with a corresponding [FlapjackViewModel]. This architecture ensures a consistent
/// pattern for managing and providing state in a Flutter application.
///
/// Subclasses are expected to override the [viewModel] method to provide an instance
/// of the corresponding [FlapjackViewModel] and the [build] method to define the UI
/// that uses the ViewModel.
///
/// Example:
/// ```
/// class MyCustomView extends FlapjackView<MyCustomViewModel> {
///   @override
///   MyCustomViewModel viewModel() => MyCustomViewModel();
///
///   @override
///   Widget build(BuildContext context, MyCustomViewModel viewModel) {
///     // Use the viewModel to construct your UI
///     return Text(viewModel.someValue);
///   }
/// }
/// ```
abstract class FlapjackView<M extends FlapjackViewModel> extends StatefulWidget {
  const FlapjackView({Key? key}) : super(key: key);

  /// Method responsible for creating an instance of [FlapjackViewModel].
  ///
  /// This is invoked during the initialization phase of the associated state.
  M viewModel();

  /// Defines the UI of the widget. Takes in the provided [FlapjackViewModel]
  /// instance for the particular view.
  Widget build(BuildContext context, M viewModel);

  @override
  FlapjackViewState<M> createState() => FlapjackViewState<M>();
}

/// The state associated with the [FlapjackView].
///
/// This state class is responsible for creating the ViewModel instance,
/// cleaning up its resources when no longer needed, and building the widget
/// tree using the provided ViewModel.
///
/// It uses [FlapjackViewModelProvider] to provide the ViewModel instance
/// to its descendants, allowing them to access the ViewModel if necessary.
final class FlapjackViewState<M extends FlapjackViewModel> extends State<FlapjackView<M>> {
  late M viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = widget.viewModel();
  }

  /// Ensures the resources held by the [FlapjackViewModel] are released when
  /// the widget is removed from the tree.
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  /// Builds the widget tree for the [FlapjackView].
  ///
  /// Uses a combination of [FlapjackViewModelProvider] and [ListenableBuilder]
  /// to ensure that the widget tree reacts to changes in the ViewModel.
  @override
  Widget build(BuildContext context) {
    return FlapjackViewModelProvider<M>(
      viewModel: viewModel,
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return widget.build(context, viewModel);
        },
      ),
    );
  }
}
