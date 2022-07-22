import 'dart:io';

void main(List<String> args) {
  print("value kiriting: ");
  var a = stdin.readLineSync()!;
  print(polindrom(a));
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
