import 'package:markdown_extend/src/converted/converted.dart';

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
  if (a is InternalLinkConverted && b is InternalLinkConverted) {
    return a.targetName == b.targetName && eq(a.named, b.named);
  }

  // GroupConverted
  if (a is GroupConverted && b is GroupConverted) {
    return eqList(a.children, b.children);
  }

  // ConvertedTitle
  if (a is ConvertedTitle && b is ConvertedTitle) {
    return a.level == b.level && eq(a.child, b.child);
  }

  // ConvertedFileEmbed
  if (a is ConvertedFileEmbed && b is ConvertedFileEmbed) {
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

  // ConvertedCode
  if (a is ConvertedCode && b is ConvertedCode) {
    return (a.lang == b.lang) && eq(a.child, b.child);
  }

  // ConvertedPre
  if (a is ConvertedPre && b is ConvertedPre) {
    return eq(a.child, b.child);
  }

  // ConvertedLi
  if (a is ConvertedLi && b is ConvertedLi) {
    return eq(a.child, b.child);
  }

  // ConvertedUl
  if (a is ConvertedUl && b is ConvertedUl) {
    return eq(a.child, b.child);
  }

  // ConvertedOl
  if (a is ConvertedOl && b is ConvertedOl) {
    return eq(a.child, b.child);
  }

  // ConvertedHr
  if (a is ConvertedHr && b is ConvertedHr) {
    return true;
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
