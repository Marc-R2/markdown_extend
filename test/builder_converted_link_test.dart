import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/link.dart';
import 'package:markdown_extend/src/converted/text.dart';
import 'package:markdown_extend/src/token/atomic.dart';
import 'package:markdown_extend/src/token/group.dart';
import 'package:test/test.dart';

void main() {
  late Builder builder;

  const tokenAtomic0 = TokenAtomic('Test');
  const tokenAtomic0txt = "TokenAtomic('Test')";
  const tokenAtomic1 = TokenAtomic('test');
  const tokenAtomic1txt = "TokenAtomic('test')";

  const tokenGroup0 = TokenGroup([tokenAtomic0, tokenAtomic1]);

  const convertedText0 = ConvertedText(tokenAtomic0);
  const convertedText1 = ConvertedText(tokenAtomic1);

  const convertedLink0 = ConvertedLink(convertedText0, tokenAtomic0);
  const convertedLink1 = ConvertedLink(convertedText1, tokenGroup0);

  setUp(() {
    builder = Builder();
  });

  test('create ConvertedLink with TokenAtomic', () {
    convertedLink0.build(builder);

    expect(builder.variableNames, hasLength(equals(3)));
    expect(builder.listBuilder, hasLength(equals(3)));

    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic0txt;'));
    expect(build, contains('const  var1 = ConvertedText(var0);'));
    expect(build, contains('const  var2 = ConvertedLink(var1, var0);'));
  });

  test('create ConvertedLink with TokenGroup', () {
    convertedLink1.build(builder);

    expect(builder.variableNames, hasLength(equals(5)));
    expect(builder.listBuilder, hasLength(equals(5)));

    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic1txt;'));
    expect(build, contains('const  var3 = $tokenAtomic0txt;'));
    expect(build, contains('const  var1 = ConvertedText(var0);'));
    expect(build, contains('const  var2 = TokenGroup([var3, var0]);'));
    expect(build, contains('const  var4 = ConvertedLink(var1, var2);'));
  });

  test('create same ConvertedLink twice', () {
    final var0 = convertedLink1.build(builder);
    final var1 = convertedLink1.build(builder);

    expect(var0, equals(var1));
  });
}
