import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/group.dart';
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
  const convertedText1 = ConvertedText(tokenGroup0);

  const convertedGroup0 = GroupConverted([convertedText0, convertedText1]);
  const convertedGroup1 = GroupConverted([convertedText0, convertedText0]);

  setUp(() {
    builder = Builder();
  });

  test('create GroupConverted with TokenAtomic', () {
    convertedGroup0.build(builder);

    expect(builder.variableNames, hasLength(equals(6)));
    expect(builder.listBuilder, hasLength(equals(6)));

    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic0txt;'));
    expect(build, contains('const  var1 = ConvertedText(var0);'));
    expect(build, contains('const  var2 = TokenGroup([var0, var3]);'));
    expect(build, contains('const  var3 = $tokenAtomic1txt;'));
    expect(build, contains('const  var4 = ConvertedText(var2);'));
    expect(build, contains('const  var5 = GroupConverted([var1, var4]);'));
  });

  test('create GroupConverted with TokenGroup', () {
    convertedGroup1.build(builder);

    expect(builder.variableNames, hasLength(equals(3)));
    expect(builder.listBuilder, hasLength(equals(3)));

    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic0txt;'));
    expect(build, contains('const  var1 = ConvertedText(var0);'));
    expect(build, contains('const  var2 = GroupConverted([var1, var1]);'));
  });

  test('create same GroupConverted twice', () {
    final var0 = convertedGroup1.build(builder);
    final var1 = convertedGroup1.build(builder);

    expect(var0, equals(var1));
  });
}
