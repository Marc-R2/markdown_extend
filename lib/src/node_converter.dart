import 'package:markdown/markdown.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/file.dart';
import 'package:markdown_extend/src/converted/italic.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/converted/paragraph.dart';
import 'package:markdown_extend/src/converted/strong.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/syntax/internal_link_syntax.dart';

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
      String() => throw Exception('Unknown element tag: $tag'),
    };
  }
}
