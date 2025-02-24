import 'package:markdown_extend/src/token/atomic.dart';
import 'package:markdown_extend/src/token/token.dart';

class TokenGroup extends Token {
  const TokenGroup(this.tokens);

  final Iterable<Token> tokens;

  @override
  Iterable<TokenAtomic> get parts => tokens.expand((e) => e.parts);

  @override
  String get text => tokens.map((e) => e.text).join();

  @override
  String toString() => 'TokenGroup($tokens)';
}
