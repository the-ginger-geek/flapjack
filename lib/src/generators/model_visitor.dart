import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/element.dart';

class ModelVisitor extends SimpleElementVisitor<void> {
  String className = '';
  final fields = <String, dynamic>{};
  final methods = <String, dynamic>{};

  @override
  void visitConstructorElement(ConstructorElement element) {
    final elementReturnType = element.type.returnType.toString();
    className = elementReturnType.replaceFirst('*', '');
  }

  @override
  void visitFieldElement(FieldElement element) {
    final elementType = element.type.toString();
    fields[element.name] = elementType.replaceFirst('*', '');
  }

  @override
  void visitMethodElement(MethodElement element) {
    final elementType = element.type.toString();
    methods[element.name] = elementType.replaceFirst('*', '');
  }
}