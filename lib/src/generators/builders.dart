import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'generators.dart';

/// A custom builder that integrates the [LoadingMethodGenerator] into the build process.
///
/// This builder produces `.flapjack.dart` part files for each input Dart file.
/// The generated files contain extension methods created by [LoadingMethodGenerator].
Builder loadingMethodBuilder(BuilderOptions options) =>
    PartBuilder([LoadingMethodGenerator()], '.flapjack.dart');
