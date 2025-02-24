import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/token/token.dart';

class InternalLinkUnnamedConverted with Converted {
  const InternalLinkUnnamedConverted(this.targetName);

  final Token targetName;

  @override
  String toString() => '[[$targetName]]';

  @override
  String debug() => 'InternalLinkUnnamedConverted($targetName)';
}

class InternalLinkNamedConverted with Converted {
  const InternalLinkNamedConverted(this.targetName, this.children);

  final Token targetName;
  final List<Converted> children;

  @override
  String toString() => '[[${targetName.text}|${children.join()}]]';

  @override
  String debug() =>
      'InternalLinkNamedConverted($targetName, ${children.map((e) => e.debug()).join(', ')})';
}
