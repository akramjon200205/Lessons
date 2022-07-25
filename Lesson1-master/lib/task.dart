import 'dart:io';

import 'package:eval_ex/expression.dart';

void main(List<String> args) {
  // print("value kiriting: ");
  // String a = stdin.readLineSync()!;
  // print(polindrom(a));

  Expression exp = Expression("2 ^ (4 + 8)");
  print(exp.eval().toString()); // 24

  // With a variable
  exp = Expression("a^b+c + (*1)");

  // Variables may contain alphanumeric characters, and "_". This can be changed
  // by using setVariableCharacters(..) and setFirstVariableCharacters(..) (what chars variable are allowed to start with).
  // exp.setStringVariable("a", "2");
  exp.setStringVariable('a', 'sin(0)');
  exp.setStringVariable("b", "4");
  exp.setStringVariable("c", "0");
  
  print(exp.eval().toString()); // 24

  // With a function
  exp = Expression("MAX(-7,8)");
  print(exp.eval().toString()); // 8

  // Boolean logic
  exp = Expression("1>0 && 5 == 5");
  print(exp.eval().toString()); // 1

  exp = Expression("1>0 && 5 == 4");
  print(exp.eval().toString()); // 0  
}


polindrom(String enterValue) {
  List polindrom = enterValue.toLowerCase().split('').toList();
  List reversePolindrom = polindrom.reversed.toList();

  for (int i = 0; i < polindrom.length; i++) {
    if (reversePolindrom[i].contains(polindrom[i])) {
      continue;
    } else {
      return false;
    }
  }
  return true;
}
