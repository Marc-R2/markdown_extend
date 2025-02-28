import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';

class ConvertedTitle with Converted {
  const ConvertedTitle(this.child, this.level);

  factory ConvertedTitle.fromElement(Element element, int level) {
    final child = GroupConverted.fromElements(element.children);
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedTitle(child, level);
  }

  final Converted? child;

  final int level;

  @override
  Iterable<Token> get tokens sync* {
    if (child != null) yield* child!.tokens;
  }

  @override
  String toString() => '${'#' * level} $child';

  @override
  String debug() => 'ConvertedTitle($child, $level)';

  @override
  String build(Builder builder) {
    final childVar = child?.build(builder);
    return builder.addConverted(debug(), 'ConvertedTitle', '$childVar, $level');
  }
}
