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
  String? _income;
  String? _expense;
  TransactionType _selectedType = TransactionType.expense;

  final incomeCalculatorVM = CalculatorViewModel();
  final expenseCalculatorVM = CalculatorViewModel();

  // intialize
  TransactionInputViewmodel() {
    _setupCalculatorListener();
  }

  void tapTransactionContainer(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        _selectedType = TransactionType.income;
        break;
      case TransactionType.expense:
        _selectedType = TransactionType.expense;
        break;
    }
    notifyListeners();
  }

  void _setupCalculatorListener() {
    incomeCalculatorVM.addListener(() {
      _income = incomeCalculatorVM.result;
      notifyListeners();
    });

    expenseCalculatorVM.addListener(() {
      _expense = expenseCalculatorVM.result;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    incomeCalculatorVM.dispose();
    expenseCalculatorVM.dispose();
    super.dispose();
  }
}
