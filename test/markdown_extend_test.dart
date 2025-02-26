import 'package:markdown_extend/src/converted/file.dart';
import 'package:markdown_extend/src/converted/internal_link.dart';
import 'package:markdown_extend/src/converted/italic.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/converted/strong.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:markdown_extend/src/token/atomic.dart';

import 'convert.dart';

void main() {
  final parse = markdownParse(
    'Hello *Markdown*, this is **markdown_extend** with internal [[links]] and images ![images](image.png), or named links [[file_abc|named]] and with formatting [[file_abc|**named**]]',
    extensionSet: extensionSet,
  );
  print(parse);
  final converted = parse.map((node) => node.convert()).toList();
  print(converted);
  print('Done');

  const italic0 = ConvertSingleTest(
    '*Markdown*',
    ConvertedItalic(ConvertedText(TokenAtomic('Markdown'))), // TODO: false),
  );
  italic0.run();

  const italic1 = ConvertSingleTest(
    '_Markdown_',
    ConvertedItalic(ConvertedText(TokenAtomic('Markdown'))),
  );
  italic1.run();

  const link0 = ConvertSingleTest(
    '[[links]]',
    InternalLinkUnnamedConverted(TokenAtomic('links')),
  );
  link0.run();

  const link1 = ConvertSingleTest(
    '[[file_abc|named]]',
    InternalLinkNamedConverted(
      TokenAtomic('file_abc'),
      ConvertedText(TokenAtomic('named')),
    ),
  );
  link1.run();

  const file0 = ConvertSingleTest(
    '![images](image.png)',
    ConvertedFile(TokenAtomic('images'), TokenAtomic('image.png')),
  );
  file0.run();

  const link2 = ConvertSingleTest(
    '[fileAbc](some.pdf)',
    ConvertedLink(
      ConvertedText(TokenAtomic('fileAbc')),
      TokenAtomic('some.pdf'),
    ),
  );
  link2.run();

  const strong0 = ConvertSingleTest(
    '**Markdown**',
    ConvertedStrong(ConvertedText(TokenAtomic('Markdown'))),
  );
  strong0.run();

  const c = ConvertBlockTest([strong0, italic0, italic1, link0, link1]);
  c.run();
}
