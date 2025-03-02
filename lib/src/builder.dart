import 'dart:io';

import 'package:code_builder/code_builder.dart';
import 'package:markdown_extend/markdown_extend.dart';

class Builder {
  /// key: actual text
  /// value: variable name
  final variableNames = <String, String>{};

  final listBuilder = <Spec>[];

  void _createTokenAtomic(String varName, String txt) => _createConst(
        varName,
        refer('TokenAtomic', 'package:markdown_extend/markdown_extend.dart'),
        [literalString(txt)],
      );

  void _createTokenGroup(String varName, TokenGroup group) {
    final childNames = group.tokens.map(addToken);
    _createConst(
      varName,
      refer('TokenGroup', 'package:markdown_extend/markdown_extend.dart'),
      [literalList(childNames)],
    );
  }

  String createVar() {
    final newVarName = '_var${variableNames.length}'; // TODO: better var naming
    assert(!variableNames.containsValue(newVarName), 'var already in use');
    return newVarName;
  }

  void _createConst(String varName, Reference constructor,
          [List<Expression> parameter = const []]) =>
      listBuilder.add(
          declareConst(varName).assign(constructor.call(parameter)).statement);

  /// Returns the variable name for a [Token]
  /// The variable will be created if not present.
  String addToken(Token token) {
    final txt = token.text;
    final known = variableNames[txt];
    if (known != null) return known;
    final newVarName = variableNames[txt] = createVar();

    if (token is TokenAtomic) {
      _createTokenAtomic(newVarName, txt);
    } else if (token is TokenGroup) {
      _createTokenGroup(newVarName, token);
    }

    return newVarName;
  }

  String addConverted(String key, String type, String parameter) {
    final known = variableNames[key];
    if (known != null) return known;
    final newVarName = variableNames[key] = createVar();
    _createConst(
      newVarName,
      refer(type, 'package:markdown_extend/markdown_extend.dart'),
      [refer(parameter)],
    );
    return newVarName;
  }

  final dirs = <ConvertedDirectory>{};

  ConvertedDirectory readDir(Directory dir) {
    final converted = _readDir(dir);
    dirs.add(converted);
    return converted;
  }

  ConvertedDirectory _readDir(Directory dir) {
    final files = <ConvertedFile>[];
    final dirs = <ConvertedDirectory>[];

    for (final file in dir.listSync()) {
      if (file is Directory) {
        final dir = _readDir(file);
        if (dir.hasFiles) dirs.add(dir);
      } else if (file is File) {
        final name = file.uri.pathSegments.last;
        if (name.endsWith('.md')) files.add(_readFile(file));
      }
    }

    return ConvertedDirectory.fromUri(dir.uri, files, dirs);
  }

  ConvertedFile _readFile(File md) {
    final converted = convertMarkdown(md.readAsStringSync());
    converted.build(this);
    return ConvertedFile.fromUri(md.uri, converted);
  }

  static final emitter = DartEmitter.scoped();

  String build() {
    final dirsVars = dirs.map((d) => d.build(this)).join(', ');
    listBuilder.add(declareConst('dirs')
        .assign(CodeExpression(Code('[$dirsVars]')))
        .statement);

    final library = LibraryBuilder();
    library.body.addAll(listBuilder);

    return library.build().accept(emitter).toString();
  }
}
