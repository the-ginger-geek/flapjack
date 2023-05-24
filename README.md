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

### 5. Finding Relative ViewModels with `findRelative`

In Flapjack, the `findRelative` method is used to find and access other view models. This is useful when you want to affect the state of another view model from a different one. 

In the example application, the `OtherButtonViewModel` uses the `findRelative` method to access the `HomeViewModel` and call its `increment` method. This demonstrates how you can interact with the state of different parts of your app in a decoupled way.

```dart
class OtherButtonViewModel extends FlapjackViewModel<OtherButtonModel> {
  OtherButtonViewModel(super.model);

  void increment() => findRelative<HomeViewModel>()?.increment();
}
```

The `findRelative` method looks for the requested type of ViewModel in the `ViewModelLocator` provided by the `Flapjack` widget. If it finds a ViewModel of the requested type, it returns it; otherwise, it returns null. This allows your ViewModels to interact with each other in a loosely coupled way.

Note: It's important to use `findRelative` responsibly to maintain a clean architecture. You should avoid creating intricate dependencies between different parts of your app, as this can make your code harder to maintain and understand.

## Conclusion

Flapjack provides a consistent and scalable architecture for your Flutter applications, separating responsibilities into distinct Model, ViewModel, and View classes. This structure allows for cleaner, more maintainable code and a better understanding of data flow within your application.