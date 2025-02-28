import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';

class ConvertedLi with Converted {
  const ConvertedLi(this.child);

  factory ConvertedLi.fromElement(Element element) {
    final child = GroupConverted.fromElements(element.children);
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedLi(child);
  }

  final Converted? child;

  @override
  Iterable<Token> get tokens sync* {
    if (child != null) yield* child!.tokens;
  }

  @override
  String toString() => '$child';

  @override
  String debug() => 'ConvertedLi($child)';

  @override
  String build(Builder builder) {
    final childVar = child?.build(builder) ?? 'null';
    return builder.addConverted(debug(), 'ConvertedLi', childVar);
  }
}
