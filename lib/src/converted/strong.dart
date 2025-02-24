import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/node_converter.dart';

class ConvertedStrong with Converted {
  const ConvertedStrong(this.children);

  factory ConvertedStrong.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert());
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedStrong(children?.toList());
  }

  final List<Converted>? children;

  @override
  String toString() => '**${children?.join('')}**';

  @override
  String debug() =>
      'ConvertedStrong(${children?.map((e) => e.debug()).join(', ')})';
}

class ConvertedItalic with Converted {
  const ConvertedItalic(this.children, [this.isUnderscore = true]);

  factory ConvertedItalic.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert());
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedItalic(children?.toList());
  }

  final List<Converted>? children;

  final bool isUnderscore;

  String get prefix => isUnderscore ? '_' : '*';

  @override
  String toString() => '$prefix${children?.join('')}$prefix';

  @override
  String debug() =>
      'ConvertedItalic(${children?.map((e) => e.debug()).join(', ')})';
}
