import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/token/atomic.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedText with Converted {
  const ConvertedText(this.token);

  final Token token;

  @override
  String toString() => token.text;
}

extension TextConverter on Text {
  ConvertedText convertText() => ConvertedText(text.toToken());
}

extension StringToToken on String {
  Token toToken() => TokenAtomic(this);
}
