# EXAMPLE FOR LINEAR YACC

Here is the example's `pubspec.yaml`:

```YAML
name: test
description: A test app for lyacc!
version: 1.0.0
homepage: https://github.com/iamtheblackunicorn/lyacc
publish_to: none
environment:
  sdk: '>=2.12.0 <3.0.0'
dependencies:
  lyacc:
    git: git://github.com/iamtheblackunicorn/lyacc.git
```

Here is the example itself:

```dart
/* Linear YACC by Alexander Abraham
licensed under the MIT license. */

import 'package:lyacc/lyacc.dart';
String version = '1.0.0';
String name = 'Bison Script';
String license = 'MIT';
String author = 'Alexander Abraham';
String quitStatement = 'end';
void printString(List<dynamic> strings){
  print(strings[0]);
}
Map<String, dynamic> tokens = {
  'PRINT':RegExp(r'(stdout)'),
  'STRING':RegExp(r'"(.*)"')
};
Map<String, dynamic> grammar = {
  'STDOUT':'PRINT STRING',
};
List<String> cosmeticTokens = [
  'stdout'
];
Map<String, dynamic> operations = {
  'STDOUT':[printString, 1],
};
void main(List<String> arguments){
  String versionString = '$name v.$version\nby $author\nlicensed under the $license license';
  String preAmble = '$name v.$version';
  app(
    arguments,
    versionString,
    preAmble,
    quitStatement,
    tokens,
    grammar,
    cosmeticTokens,
    operations
  );
}
```
