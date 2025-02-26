import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/converted/file.dart';
import 'package:markdown_extend/src/converted/group.dart';
import 'package:markdown_extend/src/converted/internal_link.dart';
import 'package:markdown_extend/src/converted/italic.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/converted/paragraph.dart';
import 'package:markdown_extend/src/converted/strong.dart';
import 'package:markdown_extend/src/converted/text.dart';

bool eq(Converted? a, Converted? b) {
  if (a == null && b == null) return true;
  if (a == null || b == null) return false;
  if (a.runtimeType != b.runtimeType) return false;

  // ConvertedText
  if (a is ConvertedText && b is ConvertedText) {
    return a.token.text == b.token.text;
  }

  // ConvertedLink
  if (a is ConvertedLink && b is ConvertedLink) {
    return a.url == b.url && eq(a.named, b.named);
  }

  // InternalLinkNamedConverted
  if (a is InternalLinkNamedConverted && b is InternalLinkNamedConverted) {
    return a.targetName == b.targetName && eq(a.named, b.named);
  }

  // InternalLinkUnnamedConverted
  if (a is InternalLinkUnnamedConverted && b is InternalLinkUnnamedConverted) {
    return a.targetName == b.targetName;
  }

  // GroupConverted
  if (a is GroupConverted && b is GroupConverted) {
    return eqList(a.children, b.children);
  }

  // ConvertedFile
  if (a is ConvertedFile && b is ConvertedFile) {
    return a.alt == b.alt && a.url == b.url;
  }

  // ConvertedStrong
  if (a is ConvertedStrong && b is ConvertedStrong) {
    return eq(a.child, b.child);
  }

  // ConvertedItalic
  if (a is ConvertedItalic && b is ConvertedItalic) {
    return (a.isUnderscore == b.isUnderscore) && eq(a.child, b.child);
  }

  // ConvertedParagraph
  if (a is ConvertedParagraph && b is ConvertedParagraph) {
    return eq(a.child, b.child);
  }
  throw Exception('Unknown Converted: $a / $b');
}

bool eqList(List<Converted>? a, List<Converted>? b) {
  if (a == null && b == null) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (!eq(a[i], b[i])) return false;
  }
  return true;
}
