import 'package:markdown_extend/markdown_extend.dart';
import 'package:markdown_extend/src/builder.dart';

abstract class BuilderFSEntry with Converted {
  const BuilderFSEntry(this.name);

  BuilderFSEntry.fromUri(Uri uri) : name = uri.pathSegments.last.isEmpty
      ? uri.pathSegments[uri.pathSegments.length - 2]
      : uri.pathSegments.last;

  final String name;
}

class ConvertedFile extends BuilderFSEntry {
  const ConvertedFile(super.name, this.converted);

  ConvertedFile.fromUri(super.uri, this.converted) : super.fromUri();

  final Converted converted;

  String get title {
    final idx = name.lastIndexOf('.');
    return idx == -1 ? name : name.substring(0, idx);
  }

  @override
  Iterable<Token> get tokens => converted.tokens;

  @override
  String build(Builder builder) {
    final childVar = converted.build(builder);
    return builder.addConverted(debug(), 'ConvertedFile', "'$name', $childVar");
  }

  @override
  String debug() => 'ConvertedFile($name, $converted)';
}

class ConvertedDirectory extends BuilderFSEntry {
  const ConvertedDirectory(super.name, this.files, this.dirs);

  ConvertedDirectory.fromUri(super.uri, this.files, this.dirs)
      : super.fromUri();

  final List<ConvertedFile> files;
  final List<ConvertedDirectory> dirs;

  Iterable<ConvertedFile> get filesRecursive sync* {
    yield* files;
    yield* dirs.expand((d) => d.filesRecursive);
  }

  @override
  Iterable<Token> get tokens sync* {
    yield* files.expand((e) => e.tokens);
    yield* dirs.expand((e) => e.tokens);
  }

  bool get hasFiles => files.isNotEmpty || dirs.any((d) => d.hasFiles);

  @override
  String build(Builder builder) {
    final filesVars = files.map((f) => f.build(builder)).join(', ');
    final dirsVars = dirs.map((d) => d.build(builder)).join(', ');
    return builder.addConverted(
      debug(),
      'ConvertedDirectory',
      "'$name', [$filesVars], [$dirsVars]",
    );
  }

  @override
  String debug() =>
      'ConvertedDirectory($name, ${files.map((f) => f.debug())}, ${dirs.map((d) => d.debug())})';
}
