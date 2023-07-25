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

  /// Generates code for a given [ClassElement] if it contains methods
  /// annotated with [LoadingMethod].
  Iterable<String> _generateForClass(ClassElement classElement) {
    return classElement.methods
        .where((method) => _hasLoadingMethodAnnotation(method))
        .map((method) => _generateForMethod(classElement, method));
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
extension ${classElement.name}Extra on ${classElement.name} {
  Future $newMethodName($parametersDeclaration) async {
    setLoading(true);
    await $originalMethodName($parametersCall);
    setLoading(false);
  }
}
''';
  }
}
