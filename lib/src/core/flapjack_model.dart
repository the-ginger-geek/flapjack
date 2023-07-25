/// An abstract base class representing the data model in the Flapjack architecture.
/// 
/// The [FlapjackModel] acts as a foundational layer for data representation, providing 
/// a consistent structure for all models in the application. By having a generic 
/// parameter `<T>`, it offers the flexibility to define specific data types that 
/// the model can hold or represent.
/// 
/// It is designed to work in tandem with [FlapjackViewModel] to separate business 
/// logic and state management from UI components, leading to more modular and 
/// maintainable code.
///
/// Example usage:
/// 
/// ```dart
/// class User extends FlapjackModel<String> {
///   final String id;
///   final String name;
///
///   User(this.id, this.name);
/// }
/// ```
/// 
/// Developers can extend this class to create more specific data models tailored
/// to the needs of their application.
abstract class FlapjackModel<T> {
  bool isLoading = false;
}