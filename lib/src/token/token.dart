import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/token/atomic.dart';

export 'package:markdown_extend/src/token/atomic.dart';
export 'package:markdown_extend/src/token/group.dart';

abstract class Token {
  const Token();

  String get text;

  Iterable<TokenAtomic> get parts;

  String build(Builder builder) => builder.addToken(this);

  @override
  bool operator ==(Object other) => other is Token && text == other.text;

  @override
  int get hashCode => text.hashCode;
}
