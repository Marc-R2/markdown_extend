import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/token/token.dart';

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
  Iterable<Token> get tokens sync* {
    if (child != null) yield* child!.tokens;
  }

  @override
  String toString() => child.toString();

  @override
  String debug() => 'ConvertedParagraph(${child?.debug()})';

  @override
  String build(Builder builder) {
    final childVar = child?.build(builder) ?? 'null';
    return builder.addConverted(debug(), 'ConvertedParagraph', childVar);
  }
}
