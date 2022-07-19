import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';

class CalculatorUtils {   
  final calculateController = TextEditingController();
  final resultController = TextEditingController();
  double topFieldSize = 35;
  double bottomFieldSize = 45;
   int theme = 10;
  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    'del',
    '=',
  ];
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
  var lastOperator = '';
  var lastOperated = '';
  bool isSimple = true;
  
  writer(String command) {
    if (command == 'C') {
      calculateController.text = '';
      resultController.text = '';
      topFieldSize = 35;
      bottomFieldSize = 45;
    } else if (command == 'del') {
      if (calculateController.text.isNotEmpty) {
        calculateController.text = calculateController.text
            .substring(0, calculateController.text.length - 1);
        var res = calculate(calculateController.text);
        if (res != null) {
          resultController.text = "=$res";
        }
      }
    } else if (command == '=') {
      if (resultController.text.isEmpty) {}
      if (resultController.text.isNotEmpty) {
        calculateController.text = resultController.text.substring(1);
        resultController.text = '';
      } else {}
    } else if (command == '+/-') {
      if (resultController.text.length > 1) {
        if (resultController.text.contains('-')) {
          resultController.text = '=${resultController.text.substring(2)}';
        } else {
          resultController.text = '=-${resultController.text.substring(1)}';
        }
      }
    } else if (command == '%') {
      if (calculateController.text.isNotEmpty) {
        var last = splitter(calculateController.text);
        var calculateText = calculateController.text;
        calculateController.text =
            '${calculateText.substring(0, calculateText.length - last.length)}${double.parse(last) / 100}';
        var res = calculate(calculateController.text);
        if (res != null) {
          resultController.text = "=$res";
        }
      }
    } else if (command == '/' ||
        command == '*' ||
        command == '+' ||
        command == '-') {
      lastOperator = command;
      if (calculateController.text.isNotEmpty &&
          !isOperator(
              calculateController.text[calculateController.text.length - 1])) {
        calculateController.text += command;
        var res = calculate(calculateController.text);
        if (res != null) {
          resultController.text = "=$res";
        }
      }
    } else if (command == '.') {
      if (calculateController.text.isNotEmpty &&
          !isOperator(
              calculateController.text[calculateController.text.length - 1])) {
        if (calculateController.text.isNotEmpty) {
          var last = splitter(calculateController.text);
          if (!last.contains('.')) {
            calculateController.text += command;
            var res = calculate(calculateController.text);
            if (res != null) {
              resultController.text = "=$res";
            }
          }
        }
      }
    } else {
      if (resultController.text.isEmpty &&
          calculateController.text.isNotEmpty) {
        calculateController.text = command;
        resultController.text = command;
      } else {
        calculateController.text += command;
        var res = calculate(calculateController.text);
        if (res != null) {
          resultController.text = "=$res";
        }
      }
    }
  }

  String splitter(String string) {
    final List<String> operators = ['/', '+', '-', '*'];
    var result = string;
    for (var element in operators) {
      result = result.split(element).last;
    }
    return result;
  }

  bool isOperator(String item) {
    var operatorList = ['/', '+', '-', '*', '.'];
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
            ? result!.toStringAsFixed(3)
            : result.toString();
      }
      var result =
          Expression(operation.substring(0, operation.length - 1)).eval();
      return result.toString().contains('.')
          ? result!.toStringAsFixed(3)
          : result.toString();
    }
    return operation;
  }
}