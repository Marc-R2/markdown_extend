import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedLink with Converted {
  const ConvertedLink(this.children, this.url);

  factory ConvertedLink.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert()).toList();
    final url = element.attributes['href'];
    return ConvertedLink(children, url?.toToken());
  }

  final List<Converted>? children;
  final Token? url;

  @override
  String toString() => '[${children?.join()}](${url?.text ?? ''})';

  @override
  String debug() => 'ConvertedLink(${children?.map((e) => e.debug()).join(', ')}, $url)';
}
