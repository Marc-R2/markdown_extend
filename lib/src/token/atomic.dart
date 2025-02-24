import 'package:markdown_extend/src/token/token.dart';

class TokenAtomic extends Token {
  const TokenAtomic(this.value);

  final String value;

  @override
  Iterable<TokenAtomic> get parts sync* {
    yield this;
  }

  @override
  String get text => value;

  @override
  String toString() => value;
}
