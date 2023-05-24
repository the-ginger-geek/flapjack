# Flapjack Sample Application

This is a sample application that demonstrates how to use the Flapjack state management library in a Flutter application. 

## Application Structure

The application consists of the following components:

- `MyApp`: The root widget of the application, wraps the entire application with the `Flapjack` widget.
- `Home`: A `FlapjackView` that displays a counter and two buttons that increment the counter.
- `OtherButton`: Another `FlapjackView` that also increments the counter on the `Home` view.
- `HomeViewModel` and `OtherButtonViewModel`: `FlapjackViewModel` instances that handle the logic for the `Home` and `OtherButton` views, respectively.
- `HomeModel` and `OtherButtonModel`: `FlapjackModel` instances that represent the state for the `Home` and `OtherButton` views, respectively.

## Usage

1. Start by running the application, you'll see a counter displayed at the center of the screen, initialized to 0, and two buttons.

2. Pressing the floating action button at the bottom right of the screen will increment the counter. This button is part of the `Home` view.

3. Pressing the second floating action button, which is the `OtherButton` view, will also increment the counter. This demonstrates the `findRelative` method, as this button is able to increment the counter by calling the `increment` method on the `HomeViewModel`.

This sample application serves as a practical example of how to structure your Flutter application using the Flapjack library, separating concerns into distinct Model, ViewModel, and View classes, and allowing interaction between different parts of your application through the `findRelative` method.