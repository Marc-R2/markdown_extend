import 'package:code_builder/code_builder.dart';
import 'package:markdown_extend/src/token/token.dart';

class Builder {
  /// key: actual text
  /// value: variable name
  final variableNames = <String, String>{};

  final listBuilder = <Spec>[];

  void _createTokenAtomic(String varName, String txt) =>
      _createConst(varName, 'TokenAtomic', "r'''$txt'''");

  void _createTokenGroup(String varName, TokenGroup group) {
    final childNames = group.tokens.map(addToken).join(', ');
    _createConst(varName, 'TokenGroup', '[$childNames]');
  }

  String createVar() {
    final newVarName = 'var${variableNames.length}'; // TODO: better var naming
    assert(!variableNames.containsValue(newVarName), 'var already in use');
    return newVarName;
  }

  void _createConst(String varName, String constructor, [String? parameter]) =>
      listBuilder.add(declareConst(varName)
          .assign(CodeExpression(Code("$constructor(${parameter ?? ''});"))));

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
    _createConst(newVarName, type, parameter);
    return newVarName;
  }

  static final emitter = DartEmitter();

  String build() {
    final library = Library((lib) => lib.body.addAll(listBuilder));
    return library.accept(emitter).toString();
  }
}
