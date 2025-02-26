import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/strong.dart';
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
  const convertedItalic0 = ConvertedItalic(convertedText0);
  const convertedText1 = ConvertedText(tokenGroup0);
  const convertedItalic1 = ConvertedItalic(convertedText1);

  setUp(() {
    builder = Builder();
  });

  test('create ConvertedItalic with TokenAtomic', () {
    convertedItalic0.build(builder);

    expect(builder.variableNames, hasLength(equals(3)));
    expect(builder.listBuilder, hasLength(equals(3)));

    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic0txt;'));
    expect(build, contains('const  var1 = ConvertedText(var0);'));
    expect(build, contains('const  var2 = ConvertedItalic(var1);'));
  });

  test('create ConvertedItalic with TokenGroup', () {
    convertedItalic1.build(builder);

    expect(builder.variableNames, hasLength(equals(5)));
    expect(builder.listBuilder, hasLength(equals(5)));

    final build = builder.build();
    expect(build, contains('const  var1 = $tokenAtomic0txt;'));
    expect(build, contains('const  var2 = $tokenAtomic1txt;'));
    expect(build, contains('const  var0 = TokenGroup([var1, var2]);'));
    expect(build, contains('const  var3 = ConvertedText(var0);'));
    expect(build, contains('const  var4 = ConvertedItalic(var3);'));
  });

  test('create same ConvertedItalic twice', () {
    final var0 = convertedItalic1.build(builder);
    final var1 = convertedItalic1.build(builder);

    expect(var0, equals(var1));
  });
}
