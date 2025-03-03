import 'dart:io';

import 'package:markdown_extend/src/builder.dart';

void main() {
  final builder = Builder();

  builder.readDir(Directory('./'));

  final build = builder.build();
  File('builder_test.dart').writeAsStringSync(build);
}
