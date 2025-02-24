import 'package:markdown_extend/src/token/token.dart';

class TokenAtomic extends Token {
  const TokenAtomic(this.value);

  final String value;

  @override
  String get text => value;

  @override
  String toString() => value;
}
