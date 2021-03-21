/* Linear YACC by Alexander Abraham
licensed under the MIT license. */

import 'dart:io';


/// This method synthesizes the matched tokens from a string of text.
/// The tokens are supplied as a map.
List<dynamic> parseText(Map<String, dynamic> tokenMap, String text){
  List<dynamic> result = [];
  List<String> lineList = text.split('\n');
  for (int x = 0; x < lineList.length; x++) {
    List<dynamic> parsedLineList = [];
    String line = lineList[x];
    if (line == '\n'){}
    else {
      for (int i = 0; i < tokenMap.length; i++) {
        String key = tokenMap.keys.elementAt(i);
        RegExp pattern = tokenMap[key];
        if (pattern.hasMatch(line) == true){
          Iterable<Match> allMatches = pattern.allMatches(line);
          for (int z = 0; z < allMatches.length; z++){
            Match match = allMatches.elementAt(z);
            int groupLength = match.groupCount + 1;
            List<dynamic> imList = [];
            for (int y = 1; y < groupLength; y++) {
              imList.add(key);
              imList.add(match.group(y));
            }
            parsedLineList.add(imList);
          }
        } else {}
      }
      if (parsedLineList.length == 0){

      } else{
        result.add(parsedLineList);
      }
    }
  }
  return result;
}

/// This method builds an AST of the matched tokens, removes all unneeded tokens and constructs an intermediate
/// representation by trying to "understand" the code it is given.
List<dynamic> constructParseTree(Map<String, dynamic> grammar, List<String> cosmeticTokens, List<dynamic> parsedTokens){
  List<dynamic> result = [];
  List<dynamic> tokens = parsedTokens;
  for (int i = 0; i < tokens.length; i++) {
    List<dynamic> tokenList = tokens[i];
    List<String> tokenNames = [];
    List<dynamic> elementList = [];
    String statementType = '';
    for (int y = 0; y < tokenList.length; y++) {
      List<dynamic> token = tokenList[y];
      tokenNames.add(token[0]);
      for (int z = 0; z < grammar.length; z++) {
        String key = grammar.keys.elementAt(z);
        String sentence = grammar[key];
        String joinedTokens = tokenNames.join(' ');
        if (joinedTokens == sentence) {
          statementType = key;
        } else {}
      }
      if (cosmeticTokens.contains(token[1]) == true) {}
      else {
        elementList.add(token[1]);
      }
    }
    elementList.insert(0, statementType);
    result.add(elementList);
  }
  return result;
}

/// This method prints a visual of the AST.
void visualParseTree(List<dynamic> parseTree) {
  String spaces = ' ';
  print('\n');
  print('root');
  for (int i = 0; i < parseTree.length; i++) {
    print('$spaces|');
    print('$spaces|');
    print('$spaces|- ${parseTree[i][0]}');
    print('$spaces|    -');
    for (int z = 1; z < parseTree[i].length; z++) {
      print('$spaces|      |');
      print('$spaces|       -${parseTree[i][z]}');
    }
  }
  print('\n');
}

/// This method takes the intermediate representation and AST from the
/// parse tree and executes a function with a given number of arguments.
/// Each function has a dynamic list of arguments. This method adds to
/// that list and runs the result.
void executeParseTree(List<dynamic> parseTree, Map<String, dynamic> functionMap) {
  for (int i = 0; i < parseTree.length; i++) {
    String operationType = parseTree[i][0];
    for (int z = 0; z < functionMap.length; z++) {
      String key = functionMap.keys.elementAt(z);
      if (key == operationType) {
        List<dynamic> parseTreeItem = parseTree[i];
        List<dynamic> actionList = functionMap[key];
        int argNumber = actionList[1] + 1;
        int rangeEnd = 0 + argNumber;
        List<dynamic> functionArgs = [];
        for (int u = 1; u < rangeEnd; u++){
          String item = parseTreeItem[u];
          functionArgs.add(item);
        }
        actionList[0]!(functionArgs);
      }
      else {}
    }
  }
}

/// This method executes each line of a given line of text!
void evaluateLine(
  Map<String, dynamic> tokenMap,
  String text,
  Map<String, dynamic> grammar,
  List<String> cosmeticTokens,
  Map<String, dynamic> functionMap
){
  List<dynamic> parsedTokens = parseText(tokenMap, text);
  List<dynamic> parseTree = constructParseTree(grammar, cosmeticTokens, parsedTokens);
  try {
    executeParseTree(parseTree, functionMap);
  } catch(e) {
    print('An error occurred!');
    exit(0);
  }
}


/// This method provides a shell method.
/// It can be customized.
void shell(
  String preAmble,
  String quitStatement,
  Map<String, dynamic> tokenMap,
  Map<String, dynamic> grammar,
  List<String> cosmeticTokens,
  Map<String, dynamic> functionMap
){
  String input = 'Unicorn Script';
  int i = 0;
  print(preAmble);
  while (input != quitStatement) {
    i = i + 1;
    String prompt = 'line\=$i> ';
    stdout.write(prompt);
    input = stdin.readLineSync().toString();
    assert(input is String);
    if (input == quitStatement) {
      exit(0);
    } else {
      evaluateLine(
        tokenMap,
        input,
        grammar,
        cosmeticTokens,
        functionMap
      );
    }
  }
}

/// This method reads the contents of a file
/// and executes each line of code.
void readFile(
  String fileName,
  Map<String, dynamic> tokenMap,
  Map<String, dynamic> grammar,
  List<String> cosmeticTokens,
  Map<String, dynamic> functionMap
){
  String fileContents = File(fileName).readAsStringSync();
  List<String> fileContentsList = fileContents.split('\n');
  for (int i = 0; i < fileContentsList.length; i++) {
    if (fileContentsList[i] == '\n'){}
    else {
      evaluateLine(
        tokenMap,
        fileContentsList[i],
        grammar,
        cosmeticTokens,
        functionMap
      );
    }
  }
}

/// This method contains the entire app/interpreter.
/// This is the only method you need to call!
void app(
  List<String> arguments,
  String versionString,
  String preAmble,
  String quitStatement,
  Map<String, dynamic> tokenMap,
  Map<String, dynamic> grammar,
  List<String> cosmeticTokens,
  Map<String, dynamic> functionMap
){
  if (arguments.length == 1){
    if (arguments[0] == '--version'){
      print(versionString);
    } else if (arguments[0] == '--shell') {
      shell(
        preAmble,
        quitStatement,
        tokenMap,
        grammar,
        cosmeticTokens,
        functionMap
      );
    } else {
      readFile(
        arguments[0],
        tokenMap,
        grammar,
        cosmeticTokens,
        functionMap
      );
    }
  } else if (arguments[0] == '--diagnostics') {
    String text = File(arguments[1]).readAsStringSync();
    List<dynamic> parsedTokens = parseText(tokenMap, text);
    List<dynamic> parseTree = constructParseTree(grammar, cosmeticTokens, parsedTokens);
    visualParseTree(parseTree);
  } else {
    print('Invalid options supplied!');
    exit(0);
  }
}
