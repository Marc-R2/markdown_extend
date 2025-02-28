import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedHr with Converted {
  const ConvertedHr();

  factory ConvertedHr.fromElement(Element element) {
    assert(element.attributes.isEmpty,
        'Unexpected attributes: ${element.attributes}');
    return ConvertedHr();
  }

  @override
  Iterable<Token> get tokens sync* {}

  @override
  String toString() => '---';

  @override
  String debug() => 'ConvertedHr()';

  @override
  String build(Builder builder) {
    return builder.addConverted(debug(), 'ConvertedHr', '');
  }
}
