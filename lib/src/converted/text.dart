import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';

class ConvertedText with Converted {
  const ConvertedText(this.text);

  final String text;

  @override
  String toString() => text;
}

extension TextConverter on Text {
  ConvertedText convertText() => ConvertedText(text);
}
