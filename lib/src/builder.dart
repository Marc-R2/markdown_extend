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
    final newVarName = 'var${variableNames.length}'; // TODO: better var naming
    assert(!variableNames.containsValue(newVarName), 'var already in use');
    return newVarName;
  }

  void _createConst(String varName, Reference constructor,
          [List<Expression> parameter = const []]) =>
      listBuilder.add(declareConst(varName)
          .assign(constructor.call(parameter)).statement);

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

  static final emitter = DartEmitter.scoped();

  String build() {
    final library = Library((lib) => lib.body.addAll(listBuilder));
    return library.accept(emitter).toString();
  }
}
