import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/group.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedCode with Converted {
  const ConvertedCode(this.child, this.lang);

  factory ConvertedCode.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert());
    final child = GroupConverted.fromList(children);
    final attr = element.attributes;
    final lang = attr['class'];
    assert(
      (attr.length == 1 && lang != null) || attr.isEmpty,
      'Unexpected attributes: $attr (class is type language)',
    );
    return ConvertedCode(child, lang);
  }

  final Converted? child;

  final String? lang;

  @override
  Iterable<Token> get tokens sync* {
    if (child != null) yield* child!.tokens;
  }

  @override
  String toString() => lang == null ? '`$child`' : '```{$lang}:$child```';

  @override
  String debug() => 'ConvertedCode($child, $lang)';

  @override
  String build(Builder builder) {
    final childVar = child?.build(builder);
    final lng = (lang == null ? ', null' : ", '$lang'");
    return builder.addConverted(debug(), 'ConvertedCode', "$childVar$lng");
  }
}
