import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/converted/file.dart';
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

  const convertedFile0 = ConvertedFile(tokenAtomic0, tokenAtomic1);
  const convertedFile1 = ConvertedFile(tokenAtomic0, tokenGroup0);

  setUp(() {
    builder = Builder();
  });

  test('create ConvertedFile with TokenAtomic', () {
    convertedFile0.build(builder);

    expect(builder.variableNames, hasLength(equals(3)));
    expect(builder.listBuilder, hasLength(equals(3)));

    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic0txt;'));
    expect(build, contains('const  var1 = $tokenAtomic1txt;'));
    expect(build, contains('const  var2 = ConvertedFile(var0, var1);'));
  });

  test('create ConvertedFile with TokenGroup', () {
    convertedFile1.build(builder);

    expect(builder.variableNames, hasLength(equals(4)));
    expect(builder.listBuilder, hasLength(equals(4)));

    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic0txt;'));
    expect(build, contains('const  var2 = $tokenAtomic1txt;'));
    expect(build, contains('const  var1 = TokenGroup([var0, var2]);'));
    expect(build, contains('const  var3 = ConvertedFile(var0, var1);'));
  });

  test('create same ConvertedFile twice', () {
    final var0 = convertedFile1.build(builder);
    final var1 = convertedFile1.build(builder);

    expect(var0, equals(var1));
  });
}
