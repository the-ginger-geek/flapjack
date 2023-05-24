final class ViewModelLocator {
  final _viewModels = <Type, dynamic>{};

  T get<T>() {
    final viewModel = _viewModels[T];
    if (viewModel == null) {
      throw Exception('ViewModel of type $T not registered');
    }
    return viewModel as T;
  }

  void register(Type t, dynamic viewModel) {
    _viewModels[t] = viewModel;
  }

  void unregister(Type t, dynamic viewModel) {
    _viewModels.remove(t);
  }
}