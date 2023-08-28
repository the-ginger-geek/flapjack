# Flapjack

Flapjack is a state management library for Flutter, providing a robust architecture to structure your Flutter applications in a scalable and maintainable way. This library aids in separating concerns between your models, view models, and views.

## Installation

First, add the Flapjack library to your `pubspec.yaml` file.

```dart
dependencies:
  flapjack: <latest-version>
```

Then, run `flutter packages get` in your terminal to fetch the library.

## Basic Usage

### 1. Setting up the Flapjack Widget

At the root of your widget tree, wrap your application in the `Flapjack` widget. This widget provides a `ViewModelLocator` that your views and view models can use to access shared state.

```dart
void main() {
  runApp(
    Flapjack(
      child: MyApp(),
    ),
  );
}
```

### 2. Creating a Model

A model in Flapjack is a class that represents your application's data. You can create a model by extending the `FlapjackModel` class.

```dart
class MyModel extends FlapjackModel<MyData> {
  // Your model implementation here.
}
```

### 3. Creating a ViewModel

A view model in Flapjack extends `FlapjackViewModel` and provides the logic behind a view. It connects the model to the view.

```dart
class MyViewModel extends FlapjackViewModel<MyModel> {
  MyViewModel(MyModel model) : super(model);
  // Your view model implementation here.
}
```

### 4. Creating a View

A view in Flapjack extends `FlapjackView` and is where you build your widgets. The view has access to the view model.

```dart
class MyView extends FlapjackView<MyViewModel> {
  MyView({Key? key}) : super(key: key);

  @override
  MyViewModel viewModel() => MyViewModel(MyModel());

  @override
  Widget build(BuildContext context, MyViewModel viewModel) {
    // Your widget building code here.
  }
}
```