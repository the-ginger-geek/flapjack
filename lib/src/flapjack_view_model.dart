import 'package:flutter/material.dart';
import 'flapjack_model.dart';

/// Represents the logic and state management component for a segment of the UI
/// in the Flapjack architecture. It acts as a bridge between the UI layer
/// (typically a Flutter widget) and the underlying data model, represented by
/// [FlapjackModel].
///
/// [FlapjackViewModel] extends [ChangeNotifier], which means it can notify its
/// listeners (usually UI components) about changes in the underlying data or state.
///
/// The main advantage of this design pattern is that it separates the business logic
/// and state from the UI layer, leading to more maintainable and testable code.
///
/// Example usage:
///
/// ```
/// class MyCustomViewModel extends FlapjackViewModel<MyCustomModel> {
///   MyCustomViewModel(MyCustomModel model) : super(model);
///
///   void someBusinessLogic() {
///     // Manipulate the model
///     notifyListeners();  // Notify the UI about the changes
///   }
/// }
/// ```
abstract class FlapjackViewModel<T extends FlapjackModel> extends ChangeNotifier {
  /// The underlying data model associated with this ViewModel.
  final T model;

  /// Constructs a [FlapjackViewModel] with the provided [FlapjackModel].
  FlapjackViewModel(this.model);
}
