import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/node_converter.dart';

class ConvertedParagraph with Converted {
  const ConvertedParagraph(this.children);

  factory ConvertedParagraph.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert());
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedParagraph(children?.toList());
  }

  final List<Converted>? children;

  @override
  String toString() => children?.join('') ?? '';

  @override
  String debug() =>
      'ConvertedParagraph(${children?.map((e) => e.debug()).join(', ')})';
}
