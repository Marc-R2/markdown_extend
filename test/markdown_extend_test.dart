import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/syntax/internal_link_syntax.dart';

void main() {
  final parse = markdownParse(
    'Hello *Markdown*, this is **markdown_extend** with internal [[links]] and images ![images](image.png), or named links [[file_abc|named]] and with formatting [[file_abc|**named**]]',
    extensionSet: extensionSet,
  );
  print(parse);
  final converted = parse.map((node) => node.convert()).toList();
  print(converted);
  print('Done');
}

final extensionSet = ExtensionSet(
  List<BlockSyntax>.unmodifiable(
    <BlockSyntax>[
      const FencedCodeBlockSyntax(),
      const TableSyntax(),
      const UnorderedListWithCheckboxSyntax(),
      const OrderedListWithCheckboxSyntax(),
      const FootnoteDefSyntax(),
      const AlertBlockSyntax(),
    ],
  ),
  List<InlineSyntax>.unmodifiable(
    <InlineSyntax>[
      InlineHtmlSyntax(),
      StrikethroughSyntax(),
      AutolinkExtensionSyntax(),
      InternalLinkSyntax(),
    ],
  ),
);

List<Node> markdownParse(
  String markdown, {
  Iterable<BlockSyntax> blockSyntaxes = const [],
  Iterable<InlineSyntax> inlineSyntaxes = const [],
  ExtensionSet? extensionSet,
  Resolver? linkResolver,
  Resolver? imageLinkResolver,
  bool inlineOnly = false,
  bool encodeHtml = true,
  bool enableTagfilter = false,
  bool withDefaultBlockSyntaxes = true,
  bool withDefaultInlineSyntaxes = true,
}) {
  final document = Document(
    blockSyntaxes: blockSyntaxes,
    inlineSyntaxes: inlineSyntaxes,
    extensionSet: extensionSet,
    linkResolver: linkResolver,
    imageLinkResolver: imageLinkResolver,
    encodeHtml: encodeHtml,
    withDefaultBlockSyntaxes: withDefaultBlockSyntaxes,
    withDefaultInlineSyntaxes: withDefaultInlineSyntaxes,
  );
  return document.parse(markdown);
}
