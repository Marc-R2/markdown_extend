import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/group.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedPre with Converted {
  const ConvertedPre(this.child);

  factory ConvertedPre.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert());
    final child = GroupConverted.fromList(children);
    assert(
      element.attributes.isEmpty,
      'Unexpected attributes: ${element.attributes}',
    );
    return ConvertedPre(child);
  }

  final Converted? child;

  @override
  Iterable<Token> get tokens sync* {
    if (child != null) yield* child!.tokens;
  }

  @override
  String toString() => '$child';

  @override
  String debug() => 'ConvertedPre($child)';

  @override
  String build(Builder builder) {
    final childVar = child?.build(builder) ?? 'null';
    return builder.addConverted(debug(), 'ConvertedPre', childVar);
  }
}
