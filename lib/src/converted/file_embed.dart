import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';

class ConvertedFileEmbed with Converted {
  const ConvertedFileEmbed(this.alt, this.url);

  factory ConvertedFileEmbed.fromElement(Element element) {
    final alt = element.attributes['alt'];
    final url = element.attributes['src'];
    return ConvertedFileEmbed(alt?.toToken(), url?.toToken());
  }

  final Token? alt;
  final Token? url;

  @override
  Iterable<Token> get tokens sync* {
    if (alt != null) yield alt!;
    if (url != null) yield url!;
  }

  @override
  String toString() => '![${alt ?? ''}](${url ?? ''})';

  @override
  String debug() => 'ConvertedFileEmbed($alt, $url)';

  @override
  String build(Builder builder) {
    final altVar = alt?.build(builder);
    final urlVar = url?.build(builder);
    return builder.addConverted(debug(), 'ConvertedFileEmbed', '$altVar, $urlVar');
  }
}