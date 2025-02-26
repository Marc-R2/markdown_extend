import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/token/token.dart';

class ConvertedLink with Converted {
  const ConvertedLink(this.named, this.url);

  factory ConvertedLink.fromElement(Element element) {
    final children = element.children?.map((node) => node.convert()).toList();
    final named = GroupConverted.fromList(children);
    final url = element.attributes['href'];
    return ConvertedLink(named, url?.toToken());
  }

  final Converted? named;
  final Token? url;

  @override
  Iterable<Token> get tokens sync* {
    if (named != null) yield* named!.tokens;
    if (url != null) yield url!;
  }

  @override
  String toString() => '[$named](${url?.text ?? ''})';

  @override
  String debug() => 'Link(${named?.debug()}, $url)';

  @override
  String build(Builder builder) {
    final namedVar = named?.build(builder);
    final urlVar = url?.build(builder);
    return builder.addConverted(debug(), 'ConvertedLink', '$namedVar, $urlVar');
  }
}

class GroupConverted with Converted {
  const GroupConverted(this.children);

  static Converted? fromList(Iterable<Converted>? list) {
    if (list == null) return null;
    if (list.length > 1) return GroupConverted(list.toList());
    return list.firstOrNull;
  }

  final List<Converted> children;

  @override
  Iterable<Token> get tokens sync* {
    yield* children.expand((c) => c.tokens);
  }

  @override
  String toString() => children.map((c) => c.toString()).join();

  @override
  String debug() => 'Group(${children.map((c) => c.debug()).join(', ')}';

  @override
  String build(Builder builder) {
    final childrenVars = children.map((c) => c.build(builder)).join(', ');
    return builder.addConverted(debug(), 'GroupConverted', '[$childrenVars]');
  }
}
