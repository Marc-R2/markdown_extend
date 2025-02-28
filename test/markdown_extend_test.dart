import 'package:markdown_extend/markdown_extend.dart';

import 'convert.dart';

void main() {
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
    InternalLinkConverted(TokenAtomic('links')),
  );
  link0.run();

  const link1 = ConvertSingleTest(
    '[[file_abc|named]]',
    InternalLinkConverted(
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
