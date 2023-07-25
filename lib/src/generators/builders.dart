import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'generators.dart';

Builder loadingMethodBuilder(BuilderOptions options) =>
    SharedPartBuilder([LoadingMethodGenerator()], 'loading_method');