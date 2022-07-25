import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';

class CalculatorUtils {
  final calculateController = TextEditingController();
  final resultController = TextEditingController();
  double topFieldSize = 35;
  double bottomFieldSize = 45;
  int minimumAccuracy = 9;
  final ValueNotifier<int> theme = ValueNotifier<int>(1);
  final List<String> numbers = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  final List<String> operators = ['/', '+', '-', '%', '=', '*', 'del'];
  final List<String> operatorsCal = ['/', '+', '-', '*'];
  var lastOperator = '';
  var lastOperated = '';
  bool isSimple = true;

  var scientificButtons = {
    'RAD': '',
    'sin': 'SINR(',
    'cos': 'COSR(',
    'tan': 'TANR(',
    'π': 'PI',
    'sinh': 'ASINR(',
    'cosh': 'ACOSR(',
    'tanh': 'ATGR(',
    'x⁻¹': '^(-1)',
    'x²': '^2',
    'x³': '^3',
    'xⁿ': '^',
    'log': 'LOG10(',
    'ln': 'LOG(',
    'e': 'e',
    'eⁿ': 'e^',
    '|x|': 'ABS(',
    '√': 'SQRT(',
    '∛': '^(-3)',
    'n!': 'FACT(',
  };

  List<Tab> myTabs = [
    const Tab(
      icon: Icon(
        Icons.calculate_outlined,
        size: 28,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.currency_exchange_sharp,
        size: 28,
      ),
    ),
    const Tab(
      icon: Icon(
        Icons.line_style,
        size: 28,
      ),
    ),
  ];

  Map<String, String> simpleButtons = {
    '(': '(',
    ')': ')',
    '÷': '/',
    '⌫': 'del',
    '7': '7',
    '8': '8',
    '9': '9',
    '×': "*",
    '4': '4',
    '5': '5',
    '6': '6',
    '-': '-',
    '1': '1',
    '2': '2',
    '3': '3',
    '+': '+',
    ',': '.',
    '0': '0',
    '%': '%',
    '=': '=',
  };

  String splitter(String string) {
    final List<String> operators = ['/', '+', '-', '*'];
    var result = string;
    for (var element in operators) {
      result = result.split(element).last;
    }
    return result;
  }

  String splitterXn(String string) {
    final List<String> operators = ["^"];
    var result = string;
    for (var element in operators) {
      result = result.split(element).first;
    }
    return result;
  }

  String splitterXnLast(String string) {
    final List<String> operators = ["^"];
    var result = string;
    for (var element in operators) {
      result = result.split(element).last;
    }
    return result;
  }

  bool isOperator(String item) {
    var operatorList = ['/', '+', '-', '*', '.', '(', ')'];
    for (var element in operatorList) {
      if (item == element) {
        return true;
      }
    }
    return false;
  }

  calculate(String operation) {
    if (operation.contains('+') ||
        operation.contains('-') ||
        operation.contains('*') ||
        operation.contains('/') ||
        operation.contains('%') ||
        operation.contains('(') ||
        operation.contains(')')) {
      if (!operators.contains(operation.split('').last)) {
        var result = Expression(operation).eval();
        return result.toString().contains('.')
            ? result!.toStringAsFixed(minimumAccuracy)
            : result.toString();
      }
      var result =
          Expression(operation.substring(0, operation.length - 1)).eval();
      return result.toString().contains('.')
          ? result!.toStringAsFixed(minimumAccuracy)
          : result.toString();
    }
    return operation;
  }
}
