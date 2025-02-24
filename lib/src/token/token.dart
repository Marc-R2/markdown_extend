abstract class Token {
  const Token();

  String get text;

  @override
  bool operator ==(Object other) => other is Token && text == other.text;

  @override
  int get hashCode => text.hashCode;
}
