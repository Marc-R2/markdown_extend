import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/code.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/file.dart';
import 'package:markdown_extend/src/converted/hr.dart';
import 'package:markdown_extend/src/converted/italic.dart';
import 'package:markdown_extend/src/converted/li.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/converted/ol.dart';
import 'package:markdown_extend/src/converted/paragraph.dart';
import 'package:markdown_extend/src/converted/strong.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/converted/title.dart';
import 'package:markdown_extend/src/syntax/internal_link_syntax.dart';

import 'converted/ul.dart';

extension NodeConverter on Node {
  Converted convert() => switch (this) {
        InternalLink() => (this as InternalLink).convertInternalLink(),
        Text() => (this as Text).convertText(),
        Element() => (this as Element).convertElement(),
        Node() => throw Exception('Unknown node type: $this'),
      };
}

extension on Element {
  Converted convertElement() {
    return switch (tag) {
      'a' => ConvertedLink.fromElement(this),
      'img' => ConvertedFile.fromElement(this),
      'p' => ConvertedParagraph.fromElement(this),
      'strong' => ConvertedStrong.fromElement(this),
      'em' => ConvertedItalic.fromElement(this),
      'h1' => ConvertedTitle.fromElement(this, 1),
      'h2' => ConvertedTitle.fromElement(this, 2),
      'h3' => ConvertedTitle.fromElement(this, 3),
      'h4' => ConvertedTitle.fromElement(this, 4),
      'h5' => ConvertedTitle.fromElement(this, 5),
      'h6' => ConvertedTitle.fromElement(this, 6),
      'code' => ConvertedCode.fromElement(this),
      'pre' => ConvertedCode.fromElement(this),
      'ul' => ConvertedUl.fromElement(this),
      'ol' => ConvertedOl.fromElement(this),
      'li' => ConvertedLi.fromElement(this),
      'hr' => ConvertedHr.fromElement(this),
      String() => throw Exception('Unknown element tag: $tag'),
    };
  }
}
