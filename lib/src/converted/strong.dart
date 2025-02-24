import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedStrong with Converted {
  const ConvertedStrong(this.child);

  factory ConvertedStrong.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert());
    final child = GroupConverted.fromList(children);
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedStrong(child);
  }

  final Converted? child;

  @override
  Iterable<Token> get tokens sync* {
    if (child != null) yield* child!.tokens;
  }

  @override
  String toString() => '**$child**';

  @override
  String debug() => 'ConvertedStrong($child)';
}

class ConvertedItalic with Converted {
  const ConvertedItalic(this.child, [this.isUnderscore = true]);

  factory ConvertedItalic.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert());
    final child = GroupConverted.fromList(children);
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
}
