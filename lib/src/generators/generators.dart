import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'annotations.dart';

// class LoadingMethodGenerator extends GeneratorForAnnotation<LoadingMethod> {
//   @override
//   generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
//     final visitor = ModelVisitor();
//     element.visitChildren(visitor);
//
//     if (element is! MethodElement) {
//       throw InvalidGenerationSourceError(
//         'Generator cannot target `$element`. `@LoadingMethod()` can only be applied to methods.',
//         element: element,
//       );
//     }
//
//     final methodName = element.name;
//     final returnType = element.returnType.getDisplayString(withNullability: false);
//
//     return '''
//       @override
//       Future<$returnType> $methodName() async {
//         setLoading(true);
//         try {
//           final result = await super.$methodName();
//           return result;
//         } finally {
//           setLoading(false);
//         }
//       }
//     ''';
//   }
// }

class LoadingMethodGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    return library.allElements
        .whereType<ClassElement>()
        .expand((classElement) => _generateForClass(classElement))
        .join('\n');
  }

  Iterable<String> _generateForClass(ClassElement classElement) {
    return classElement.methods
        .where((method) => _hasLoadingMethodAnnotation(method))
        .map((method) => _generateForMethod(classElement, method));
  }

  bool _hasLoadingMethodAnnotation(MethodElement method) {
    return const TypeChecker.fromRuntime(LoadingMethod)
        .hasAnnotationOf(method);
  }

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