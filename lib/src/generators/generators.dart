import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'annotations.dart';

/// A custom code generator that produces extension methods for classes
/// that have methods annotated with [LoadingMethod].
///
/// The generated extension methods wrap the original methods with loading logic.
class LoadingMethodGenerator extends Generator {

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    // Iterate over all class elements in the library and generate code for each.
    return library.allElements
        .whereType<ClassElement>()
        .expand((classElement) => _generateForClass(classElement))
        .join('\n');
  }

  /// Generates a single extension for the given [ClassElement] that contains
  /// methods wrapped with loading state management.
  ///
  /// This function inspects the [ClassElement] for methods annotated with
  /// [LoadingMethod]. For each annotated method, it generates a new method
  /// that wraps the original with `setLoading(true)` and `setLoading(false)`
  /// calls. All these generated methods are grouped under a single extension
  /// for the class.
  ///
  /// If the class does not have any methods annotated with [LoadingMethod],
  /// this function returns an empty iterable.
  ///
  /// Example:
  /// For a class with methods `_$fetchData` and `_$updateData` annotated with
  /// [LoadingMethod], this function will produce an extension with methods
  /// `fetchData` and `updateData` that include the loading state management.
  Iterable<String> _generateForClass(ClassElement classElement) {
    // Get all methods with the LoadingMethod annotation
    var annotatedMethods = classElement.methods
        .where((method) => _hasLoadingMethodAnnotation(method))
        .toList();

    // If there are no annotated methods, return an empty iterable
    if (annotatedMethods.isEmpty) {
      return const Iterable.empty();
    }

    // Generate the extension methods for each annotated method
    var methodsCode = annotatedMethods
        .map((method) => _generateForMethod(classElement, method))
        .join('\n');

    // Return the complete extension code
    return [
      '''
extension ${classElement.name}Extra on ${classElement.name} {
  $methodsCode
}
'''
    ];
  }


  /// Checks if a given [MethodElement] is annotated with [LoadingMethod].
  bool _hasLoadingMethodAnnotation(MethodElement method) {
    return const TypeChecker.fromRuntime(LoadingMethod)
        .hasAnnotationOf(method);
  }

  /// Generates an extension method for a given [MethodElement] within its
  /// enclosing [ClassElement]. The generated method wraps the original method
  /// with loading logic.
  String _generateForMethod(ClassElement classElement, MethodElement method) {
    var originalMethodName = method.name; // e.g., _$increment
    var newMethodName = originalMethodName.substring(2); // Remove the _$ prefix

    // Generate a string representation of the parameters for method declaration.
    var parametersDeclaration = method.parameters.map((param) {
      return '${param.type.getDisplayString(withNullability: true)} ${param.name}';
    }).join(', ');

    // Generate a string representation of the parameter names for method call.
    var parametersCall = method.parameters.map((param) => param.name).join(', ');

    return '''
  Future $newMethodName($parametersDeclaration) async {
    setLoading(true);
    await $originalMethodName($parametersCall);
    setLoading(false);
  }
''';
  }
}
