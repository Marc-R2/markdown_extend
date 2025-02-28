import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/token/token.dart';

class GroupConverted with Converted {
  const GroupConverted(this.children);

  static Converted? fromList(Iterable<Converted>? list) {
    if (list == null) return null;
    if (list.length > 1) return GroupConverted(list.toList());
    return list.firstOrNull;
  }

  static fromElements(List<Node>? children) =>
      fromList(children?.map((c) => c.convert()));

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
