import 'package:flapjack/src/core/loader_meta_data.dart';
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

  /// Sets the model into a loading state
  void setLoading(LoaderMetaData loaderMetaData) {
    model.loaderMetaData = loaderMetaData;
    notifyListeners();
  }

  /// Returns the loading state of the model
  bool get isLoading => model.loaderMetaData.isLoading;

  // Checks if a specific widget is loading
  bool isWidgetLoading(String key) => model.loaderMetaData.isLoadingForKey(key);

  Future<R> asyncExecutable<R>({required Future<R> Function() executable, String? loadKey}) async {
    setLoading(LoaderMetaData(true, loaderKey: loadKey));
    final R executionResult = await executable();
    setLoading(LoaderMetaData(false, loaderKey: loadKey));
    return executionResult;
  }
}
