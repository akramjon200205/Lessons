import 'dart:math';

import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
import 'package:lesson1/utils/hive_util.dart';

class CalculatorUtils{
  final calculateController = TextEditingController();
  final resultController = TextEditingController();
  double topFieldSize = 35;
  double bottomFieldSize = 45;
  var scrollConrtoller = ScrollController();
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
  final List<String> operatorsCal = ['/', '+', '-', '*'];
  var lastOperator = '';
  var lastOperated = '';
  bool isSimple = true;

  

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
