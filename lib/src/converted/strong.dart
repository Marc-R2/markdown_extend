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
}