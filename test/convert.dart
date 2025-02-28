import 'package:markdown_extend/markdown_extend.dart';
import 'package:markdown_extend/src/node_converter.dart';
import 'package:test/test.dart';

import 'eq.dart';

abstract class ConvertTest {
  const ConvertTest();

  void run();
}

class ConvertSingleTest extends ConvertTest {
  const ConvertSingleTest(this.input, this.expected);

  final String input;

  final Converted expected;

  @override
  void run() {
    test('Convert Test - $input to $expected', () {
      final parse = markdownParse(
        input,
        extensionSet: extensionSet,
      );
      final expected = [ConvertedParagraph(this.expected)];
      final converted = parse.map((node) => node.convert()).toList();
      expect(converted.length, expected.length);
      expect(
        eqList(converted, expected),
        isTrue,
        reason:
            '${converted.map((e) => e.debug()).join(', ')} != ${expected.map((e) => e.debug()).join(', ')}',
      );
    });
  }
}

class ConvertBlockTest extends ConvertTest {
  const ConvertBlockTest(this.inputs);

  final List<ConvertSingleTest> inputs;

  @override
  void run() {
    final input = inputs.map((e) => e.input).join('');
    final expects = GroupConverted.fromList(inputs.map((e) => e.expected));
    test('Convert Test - $input to $expects', () {
      final parse = markdownParse(
        input,
        extensionSet: extensionSet,
      );
      final expected = [ConvertedParagraph(expects)];
      final converted = parse.map((node) => node.convert()).toList();
      print(converted);
      print(expected);
      expect(eqList(converted, expected), isTrue);
    });
  }
}
