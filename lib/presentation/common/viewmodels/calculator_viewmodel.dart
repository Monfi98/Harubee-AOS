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
  String get _previousKey => _expression[_expression.length - 1];

  void pressKey(String currentKey) {
    switch (currentKey) {
      case var key when (key.isNumeric):
        final isZero = 0 == int.parse(currentKey);
        if ((_expression.isEmpty || ["+", "−"].contains(_previousKey)) &&
            isZero) {
          return;
        }
        _expression += currentKey;
        _result = eval(_expression).toString();
        break;

      case "AC":
        _expression = "";
        break;

      case "+":
      case "−":
        if (_expression.isEmpty || ["+", "−"].contains(_previousKey)) {
          return;
        }
        _expression += currentKey;

      case "backspace":
        if (_expression.isEmpty) {
          return;
        }
        _expression = _expression.substring(0, _expression.length - 1);
        break;
    }
    notifyListeners();
  }
}
