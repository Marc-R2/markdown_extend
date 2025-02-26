import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/token/token.dart';

mixin Converted {
  Iterable<Token> get tokens;

  String debug();

  String build(Builder builder);
}
