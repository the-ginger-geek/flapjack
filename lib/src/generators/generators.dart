import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'annotations.dart';

/// A custom code generator that produces extension methods for classes
/// that have methods annotated with [AsyncLoader].
///
/// The generated extension methods wrap the original methods with loading logic.
class AsyncLoaderGenerator extends Generator {

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
  /// [AsyncLoader]. For each annotated method, it generates a new method
  /// that wraps the original with `setLoading(true)` and `setLoading(false)`
  /// calls. All these generated methods are grouped under a single extension
  /// for the class.
  ///
  /// If the class does not have any methods annotated with [AsyncLoader],
  /// this function returns an empty iterable.
  ///
  /// Example:
  /// For a class with methods `_$fetchData` and `_$updateData` annotated with
  /// [AsyncLoader], this function will produce an extension with methods
  /// `fetchData` and `updateData` that include the loading state management.
  Iterable<String> _generateForClass(ClassElement classElement) {
    // Get all methods with the AsyncLoader annotation
    var annotatedMethods = classElement.methods
        .where((method) => _hasAsyncLoaderAnnotation(method))
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


  /// Checks if a given [MethodElement] is annotated with [AsyncLoader].
  bool _hasAsyncLoaderAnnotation(MethodElement method) {
    return const TypeChecker.fromRuntime(AsyncLoader)
        .hasAnnotationOf(method);
  }

  /// Generates an extension method for a given [MethodElement] within its
  /// enclosing [ClassElement]. The generated method wraps the original method
  /// with loading logic.
  String _generateForMethod(ClassElement classElement, MethodElement method) {
    const asyncLoaderChecker = TypeChecker.fromRuntime(AsyncLoader);
    final annotation = asyncLoaderChecker.firstAnnotationOf(method);
    final originalMethodName = method.name;
    final metaDataParameters = [];
    String? newMethodName;

    if (annotation != null) {
      final annotatedMethodName = annotation.getField('methodName')?.toStringValue();
      if (annotatedMethodName?.isNotEmpty ?? false) {
        newMethodName = annotatedMethodName;
      }

      // key associated with the load function
      final loaderKeyObject = annotation.getField('loaderKey')?.toStringValue();
      if (loaderKeyObject != null) {
        metaDataParameters.add('loaderKey: \'$loaderKeyObject\'');
      }
    }

    newMethodName ??= originalMethodName.substring(2);

    // Generate a string representation of the parameters for method declaration.
    var parametersDeclaration = method.parameters.map((param) {
      return '${param.type.getDisplayString(withNullability: true)} ${param.name}';
    }).join(', ');

    // Generate a string representation of the parameter names for method call.
    var parametersCall = method.parameters.map((param) => param.name).join(', ');

    // Loader Meta Data parameters
    var loadingParameters = '';
    if (metaDataParameters.length == 1) {
      loadingParameters = ', ${metaDataParameters[0]}';
    } else {
      loadingParameters = metaDataParameters.join(', ');
    }

    return '''
      Future $newMethodName($parametersDeclaration) async {
        setLoading(LoaderMetaData(true$loadingParameters));
        await $originalMethodName($parametersCall);
        setLoading(LoaderMetaData(false$loadingParameters));
      }
    ''';
  }
}
