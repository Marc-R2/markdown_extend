import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/converted.dart';
import 'package:markdown_extend/src/token/token.dart';

class InternalLinkConverted with Converted {
  const InternalLinkConverted(this.targetName, [this.named]);

  final Token targetName;
  final Converted? named;

  @override
  Iterable<Token> get tokens sync* {
    yield targetName;
    if (named != null) yield* named!.tokens;
  }

  @override
  String toString() =>
      '[[${targetName.text}${named != null ? '|$named' : ''}]]';

  @override
  String debug() => 'InternalLinkConverted($targetName, ${named?.debug()})';

  @override
  String build(Builder builder) {
    final namedVar = named?.build(builder);
    final targetVar = targetName.build(builder);
    return builder.addConverted(
      debug(),
      'InternalLinkConverted',
      '$targetVar${namedVar == null ? '' : ', $namedVar'}',
    );
  }
}
