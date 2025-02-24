import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedFile with Converted {
  const ConvertedFile(this.alt, this.url);

  factory ConvertedFile.fromElement(Element element) {
    final alt = element.attributes['alt'];
    final url = element.attributes['src'];
    return ConvertedFile(alt?.toToken(), url?.toToken());
  }

  final Token? alt;
  final Token? url;

  @override
  String toString() => '![${alt ?? ''}](${url ?? ''})';
}