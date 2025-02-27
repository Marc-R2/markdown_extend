import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/group.dart';
import 'package:markdown_extend/src/converted/internal_link.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/node_converter.dart';

mixin InternalLink on Element {
  static const nodeName = 'internalLink';

  String get targetName;

  Converted convertInternalLink();
}

class InternalLinkUnnamed extends Element with InternalLink {
  InternalLinkUnnamed(this.targetName)
      : super.text(InternalLink.nodeName, targetName);

  @override
  final String targetName;

  @override
  InternalLinkConverted convertInternalLink() =>
      InternalLinkConverted(targetName.toToken());
}

class InternalLinkNamed extends Element with InternalLink {
  InternalLinkNamed(this.targetName, List<Node> children)
      : super(InternalLink.nodeName, children);

  @override
  final String targetName;

  @override
  InternalLinkConverted convertInternalLink() => InternalLinkConverted(
        targetName.toToken(),
        GroupConverted.fromList(children!.map((c) => c.convert())),
      );
}

class InternalLinkSyntax extends InlineSyntax {
  InternalLinkSyntax() : super(r'\[\[([^\]|]+)(?:\|([^\]]+))?\]\]');

  @override
  bool onMatch(InlineParser parser, Match match) {
    final linkText = match[1]!;
    final linkName = match[2];

    final anchor = linkName == null
        ? InternalLinkUnnamed(linkText)
        : InternalLinkNamed(
            linkText,
            InlineParser(linkName, parser.document).parse(),
          );

    parser.addNode(anchor);
    return true;
  }
}
