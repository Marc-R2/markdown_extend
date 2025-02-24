import 'package:markdown_extend/src/token/token.dart';

mixin Converted {
  Iterable<Token> get tokens;

  String debug();
}
