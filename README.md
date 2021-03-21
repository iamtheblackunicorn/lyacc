# LINEAR YACC :water_buffalo:

[![Build Status](https://travis-ci.com/iamtheblackunicorn/lyacc.svg?branch=main)](https://travis-ci.com/iamtheblackunicorn/lyacc)

*An over-powered engine to make language development in Dart easier. Your rules. Your language.* :water_buffalo:

## About :books:

## Installation :inbox_tray:

### Adding to your project

To add *Linear YACC* to your project's dependencies, add this line to your project's `pubspec.yaml`:

#### From *GitHub*

```YAML
depdencies:
  ...
  lyacc:
    git: git://github.com/iamtheblackunicorn/lyacc.git
```

#### From *Pub.dev*

```YAML
depdencies:
  ...
  lyacc: ^1.0.0-nullsafety.0
```

## Usage :hammer:

### Importing

Import the engine-API like this:

```dart
import 'package:lyacc/lyacc.dart';
```

### API


#### List<dynamic> parseText(Map<String, dynamic> tokenMap, String text)
This method synthesizes the matched tokens from a string of text.
The tokens are supplied as a map.

#### List<dynamic> constructParseTree(Map<String, dynamic> grammar, List<String> cosmeticTokens, List<dynamic> parsedTokens)
This method builds an AST of the matched tokens, removes all unneeded tokens and constructs an intermediate
representation by trying to "understand" the code it is given.

#### void visualParseTree(List<dynamic> parseTree)
This method prints a visual of the AST.

#### void executeParseTree(List<dynamic> parseTree, Map<String, dynamic> functionMap)
This method takes the intermediate representation and AST from the
parse tree and executes a function with a given number of arguments.
Each function has a dynamic list of arguments. This method adds to
that list and runs the result.

#### void evaluateLine(Map<String, dynamic> tokenMap,String text,Map<String, dynamic> grammar,List<String> cosmeticTokens,Map<String, dynamic> functionMap)
This method executes each line of a given line of text!

#### void shell(String preAmble,String quitStatement,Map<String, dynamic> tokenMap,Map<String, dynamic> grammar,List<String> cosmeticTokens,Map<String, dynamic> functionMap)
This method provides a shell method.
It can be customized.

#### void readFile(String fileName,Map<String, dynamic> tokenMap,Map<String, dynamic> grammar,List<String> cosmeticTokens,Map<String, dynamic> functionMap)
This method reads the contents of a file
and executes each line of code.

#### void app(List<String> arguments,String versionString,String preAmble,String quitStatement,Map<String, dynamic> tokenMap,Map<String, dynamic> grammar,List<String> cosmeticTokens,Map<String, dynamic> functionMap)
This method contains the entire app/interpreter.
This is the only method you need to call!

## Note :scroll:

- *Linear YACC* by Alexander Abraham :black_heart: a.k.a. *"The Black Unicorn"* :unicorn:
- licensed under the MIT license
