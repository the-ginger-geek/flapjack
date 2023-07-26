import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'generators.dart';

/// A custom builder that integrates the [AsyncLoaderGenerator] into the build process.
///
/// This builder produces `.flapjack.dart` part files for each input Dart file.
/// The generated files contain extension methods created by [AsyncLoaderGenerator].
Builder asyncLoaderBuilder(BuilderOptions options) =>
    PartBuilder([AsyncLoaderGenerator()], '.flapjack.dart');
