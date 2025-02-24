import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/node_converter.dart';

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
  String toString() => '$prefix$child$prefix';

  @override
  String debug() => 'ConvertedItalic($child)';
}
