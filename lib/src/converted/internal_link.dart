import 'package:markdown_extend/src/converted/converted.dart';

class InternalLinkUnnamedConverted with Converted {
  const InternalLinkUnnamedConverted(this.targetName);

  final String targetName;

  @override
  String toString() => '[[$targetName]]';
}

class InternalLinkNamedConverted with Converted {
  const InternalLinkNamedConverted(this.targetName, this.children);

  final String targetName;
  final List<Converted> children;

  @override
  String toString() => '[[$targetName|${children.join()}]]';
}
