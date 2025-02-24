import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';

class ConvertedFile with Converted {
  const ConvertedFile(this.alt, this.url);

  factory ConvertedFile.fromElement(Element element) {
    final alt = element.attributes['alt'];
    final url = element.attributes['src'];
    return ConvertedFile(alt, url);
  }

  final String? alt;
  final String? url;

  @override
  String toString() => '![${alt ?? ''}](${url ?? ''})';
}