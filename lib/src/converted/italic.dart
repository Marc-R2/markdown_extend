import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/group.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedItalic with Converted {
  const ConvertedItalic(this.child, [this.isUnderscore = true]);

  factory ConvertedItalic.fromElement(Element element) {
    final child = GroupConverted.fromElements(element.children);
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedItalic(child);
  }

  final Converted? child;

  final bool isUnderscore;

  String get prefix => isUnderscore ? '_' : '*';

  @override
  Iterable<Token> get tokens sync* {
    if (child != null) yield* child!.tokens;
  }

  @override
  String toString() => '$prefix$child$prefix';

  @override
  String debug() => 'ConvertedItalic($child)';

  @override
  String build(Builder builder) {
    final childVar = child?.build(builder) ?? 'null';
    return builder.addConverted(debug(), 'ConvertedItalic', childVar);
  }
}
