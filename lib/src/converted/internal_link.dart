import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/token/token.dart';

class InternalLinkUnnamedConverted with Converted {
  const InternalLinkUnnamedConverted(this.targetName);

  final Token targetName;

  @override
  String toString() => '[[$targetName]]';

  @override
  String debug() => 'InternalLinkUnnamedConverted($targetName)';
}

class InternalLinkNamedConverted with Converted {
  const InternalLinkNamedConverted(this.targetName, this.named);

  final Token targetName;
  final Converted named;

  @override
  String toString() => '[[${targetName.text}|$named]]';

  @override
  String debug() => 'InternalLinkNamedConverted($targetName, ${named.debug()})';
}
