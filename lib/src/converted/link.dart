import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedLink with Converted {
  const ConvertedLink(this.text, this.url);

  factory ConvertedLink.fromElement(Element element) {
    final text = element.textContent;
    final url = element.attributes['href'];
    return ConvertedLink(text.toToken(), url?.toToken());
  }

  final Token text;
  final Token? url;

  @override
  String toString() => '[${text.text}](${url?.text ?? ''})';
}
