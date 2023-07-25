import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'annotations.dart';
import 'model_visitor.dart';

class LoadingMethodGenerator extends GeneratorForAnnotation<LoadingMethod> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    if (element is! MethodElement) {
      throw InvalidGenerationSourceError(
        'Generator cannot target `$element`. `@LoadingMethod()` can only be applied to methods.',
        element: element,
      );
    }

    final methodName = element.name;
    final returnType = element.returnType.getDisplayString(withNullability: false);

    return '''
      @override
      Future<$returnType> $methodName() async {
        setLoading(true);
        try {
          final result = await super.$methodName();
          return result;
        } finally {
          setLoading(false);
        }
      }
    ''';
  }
}