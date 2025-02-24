import 'package:markdown_extend/src/token/atomic.dart';

abstract class Token {
  const Token();

  String get text;

  Iterable<TokenAtomic> get parts;

  @override
  bool operator ==(Object other) => other is Token && text == other.text;

  @override
  int get hashCode => text.hashCode;
}
