import 'package:flutter/material.dart';
import 'package:harubee/helper/string_extension.dart';
import 'package:dart_eval/dart_eval.dart';

class CalculatorViewModel extends ChangeNotifier {
  // State
  String get expression => _expression.formattedExpression;
  String get result => _result.formattedExpression;

  // Internal Variable
  String _expression = "";
  String _result = "";
  String? get _lastKey =>
      _expression.isEmpty ? null : _expression[_expression.length - 1];
  final _operators = ["+", "-"];

  void pressKey(String currentKey) {
    switch (currentKey) {
      case var key when (key.isNumeric):
        _expression += currentKey;
      case "+":
      case "-":
        if (_expression.isEmpty || _operators.contains(_lastKey)) {
          return;
        }
        _expression += currentKey;
        break;
      case "AC":
        _expression = "0";
        break;

      case "backspace":
        if (_expression.isEmpty) {
          return;
        }
        if (_expression.length <= 1) {
          _expression = "0";
        } else {
          _expression = _expression.substring(0, _expression.length - 1);
        }
        break;
    }

    if (_operators.contains(_lastKey)) {
      _result = eval('${_expression}0').toString();
    } else {
      _result = eval(_expression).toString();
    }
    notifyListeners();
  }
}
