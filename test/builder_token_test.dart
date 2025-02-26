import 'package:markdown_extend/src/builder.dart';
import 'package:markdown_extend/src/token/atomic.dart';
import 'package:markdown_extend/src/token/group.dart';
import 'package:test/test.dart';

void main() {
  late Builder builder;

  const tokenAtomic0 = TokenAtomic('Test');
  const tokenAtomic0txt = "TokenAtomic('Test');";
  const tokenAtomic1 = TokenAtomic('test');
  const tokenAtomic1txt = "TokenAtomic('test');";

  const tokenGroup0 = TokenGroup([tokenAtomic0, tokenAtomic1]);

  setUp(() {
    builder = Builder();
  });

  test('create single token', () {
    builder.addToken(tokenAtomic0);
    expect(builder.variableNames, hasLength(equals(1)));
    expect(builder.listBuilder, hasLength(equals(1)));
    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic0txt'));
  });

  test('write single token twice', () {
    builder.addToken(tokenAtomic0);
    builder.addToken(tokenAtomic0);
    expect(builder.variableNames, hasLength(equals(1)));
    expect(builder.listBuilder, hasLength(equals(1)));
    final build = builder.build();
    expect(build, contains('const  var0 = $tokenAtomic0txt'));
  });

  test('write two tokens', () {
    builder.addToken(tokenAtomic0);
    builder.addToken(tokenAtomic1);
    expect(builder.variableNames, hasLength(equals(2)));
    expect(builder.listBuilder, hasLength(equals(2)));
    final build = builder.build();
    expect(build, contains("const  var0 = $tokenAtomic0txt"));
    expect(build, contains("const  var1 = $tokenAtomic1txt"));
  });

  test('write token group - fresh', () {
    builder.addToken(tokenGroup0);
    expect(builder.variableNames, hasLength(equals(3)));
    expect(builder.listBuilder, hasLength(equals(3)));
    final build = builder.build();
    expect(build, contains("const  var0 = TokenGroup([var1, var2]);"));
    expect(build, contains("const  var1 = $tokenAtomic0txt"));
    expect(build, contains("const  var2 = $tokenAtomic1txt"));
  });

  test('write token group - reuse one previous token', () {
    builder.addToken(tokenAtomic0);
    builder.addToken(tokenGroup0);

    expect(builder.variableNames, hasLength(equals(3)));
    expect(builder.listBuilder, hasLength(equals(3)));

    final build = builder.build();
    expect(build, contains("const  var0 = $tokenAtomic0txt"));
    expect(build, contains("const  var1 = TokenGroup([var0, var2]);"));
    expect(build, contains("const  var2 = $tokenAtomic1txt"));
  });

  test('write token group - reuse both previous tokens', () {
    builder.addToken(tokenAtomic1);
    builder.addToken(tokenAtomic0);
    builder.addToken(tokenGroup0);

    expect(builder.variableNames, hasLength(equals(3)));
    expect(builder.listBuilder, hasLength(equals(3)));

    final build = builder.build();
    expect(build, contains("const  var0 = $tokenAtomic1txt"));
    expect(build, contains("const  var1 = $tokenAtomic0txt"));
    expect(build, contains("const  var2 = TokenGroup([var1, var0]);"));
  });
}
