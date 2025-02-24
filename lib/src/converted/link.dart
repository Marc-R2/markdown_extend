import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';

class ConvertedLink with Converted {
  const ConvertedLink(this.text, this.url);

  factory ConvertedLink.fromElement(Element element) {
    final text = element.textContent;
    final url = element.attributes['href'];
    return ConvertedLink(text, url);
  }

  final String text;
  final String? url;

  @override
  String toString() => '[$text](${url ?? ''})';
}
