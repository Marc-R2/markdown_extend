import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/node_converter.dart';

class ConvertedParagraph with Converted {
  const ConvertedParagraph(this.child);

  factory ConvertedParagraph.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert());
    final child = GroupConverted.fromList(children);
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedParagraph(child);
  }

  final Converted? child;

  @override
  String toString() => child.toString();

  @override
  String debug() => 'ConvertedParagraph(${child?.debug()})';
}
