import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/converted/paragraph.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/syntax/internal_link_syntax.dart';
import 'package:test/test.dart';

import 'eq.dart';

abstract class ConvertTest {
  const ConvertTest();

  void run();
}

class ConvertSingleTest extends ConvertTest {
  const ConvertSingleTest(this.input, this.expected);

  final String input;

  final Converted expected;

  @override
  void run() {
    test('Convert Test - $input to $expected', () {
      final parse = markdownParse(
        input,
        extensionSet: extensionSet,
      );
      final expected = [ConvertedParagraph(this.expected)];
      final converted = parse.map((node) => node.convert()).toList();
      expect(converted.length, expected.length);
      expect(
        eqList(converted, expected),
        isTrue,
        reason:
            '${converted.map((e) => e.debug()).join(', ')} != ${expected.map((e) => e.debug()).join(', ')}',
      );
    });
  }
}

class ConvertBlockTest extends ConvertTest {
  const ConvertBlockTest(this.inputs);

  final List<ConvertSingleTest> inputs;

  @override
  void run() {
    final input = inputs.map((e) => e.input).join('');
    final expects = GroupConverted.fromList(inputs.map((e) => e.expected));
    test('Convert Test - $input to $expects', () {
      final parse = markdownParse(
        input,
        extensionSet: extensionSet,
      );
      final expected = [ConvertedParagraph(expects)];
      final converted = parse.map((node) => node.convert()).toList();
      print(converted);
      print(expected);
      expect(eqList(converted, expected), isTrue);
    });
  }
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
