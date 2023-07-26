/// An annotation used to augment methods with loading state management.
///
/// When applied to a method, the generated code will wrap the method's
/// execution with `setLoading(true)` at the beginning and `setLoading(false)`
/// at the end. This is useful for automatically managing loading states
/// during asynchronous operations.
///
/// Usage:
/// To use this annotation, prefix the target method with `_$`. The generator
/// will then produce a new method without the `_$` prefix that includes the
/// loading state management.
///
/// Example:
/// ```dart
/// @AsyncLoader()
/// Future _$fetchData() async {
///   // original method implementation
/// }
/// ```
/// The generator will produce a `fetchData` method that wraps the original
/// `_$fetchData` with loading state calls.
class AsyncLoader {
  final String? methodName;
  final String? loaderKey;

  const AsyncLoader({this.methodName, this.loaderKey});
}
