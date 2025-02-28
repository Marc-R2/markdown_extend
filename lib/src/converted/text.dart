import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';

class ConvertedText with Converted {
  const ConvertedText(this.token);

  final Token token;

  @override
  Iterable<Token> get tokens sync* {
    yield token;
  }

  @override
  String toString() => token.text;

  @override
  String debug() => 'ConvertedText($token)';

  @override
  String build(Builder builder) {
    final tokenVar = token.build(builder);
    return builder.addConverted(debug(), 'ConvertedText', tokenVar);
  }
}

extension TextConverter on Text {
  ConvertedText convertText() => ConvertedText(text.toToken());
}

extension StringToToken on String {
  Token toToken() => TokenAtomic(this);
}
