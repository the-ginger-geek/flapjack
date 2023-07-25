import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'src/generators/generators.dart';

Builder loadingMethodBuilder(BuilderOptions options) =>
    PartBuilder([LoadingMethodGenerator()], '.flapjack.dart');
