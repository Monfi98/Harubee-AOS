import 'package:flutter/material.dart';
import 'package:harubee/helper/string_extension.dart';
import 'package:harubee/presentation/common/viewmodels/calculator_viewmodel.dart';

enum TransactionType { income, expense }

class TransactionInputViewmodel extends ChangeNotifier {
  // State
  String get income => _income?.formattedExpression ?? "-";
  String get expense => _expense?.formattedExpression ?? "-";
  TransactionType get selectedType => _selectedType;

  // Internal Variable
  String? _income = null;
  String? _expense = null;
  TransactionType _selectedType = TransactionType.expense;

  final calculatorVM = CalculatorViewModel();

  TransactionInputViewmodel() {
    calculatorVM.addListener(() {
      if (_selectedType == TransactionType.income) {
        _income = calculatorVM.result; // 현재 계산 결과를 income에 반영
      } else {
        _expense = calculatorVM.result; // 현재 계산 결과를 expense에 반영
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    calculatorVM.dispose();
    super.dispose();
  }
}
