import 'package:flutter/material.dart';
import 'package:harubee/core/utils/string_extension.dart';
import 'package:harubee/domain/models/daily_budget.dart';
import 'package:harubee/domain/models/salary_budget.dart';
import 'package:harubee/domain/models/transaction_item.dart';

class DayDetailViewmodel extends ChangeNotifier {
  // State
  DateTime get selectedDate => _selectedDate;
  String get harubee => _harubee.toString().formattedExpression;
  List<List<DateTime>> get weekDayMatrix => _weekDayMatrix;
  List<String> get memos => _currDailyBudget?.memo ?? [];
  List<TransactionItem> get fixedExpenses => _fixedExpenses;

  // internal variable
  DateTime _selectedDate;
  List<List<DateTime>> _weekDayMatrix = [];
  List<TransactionItem> _fixedExpenses = [];
  DailyBudget? _currDailyBudget;
  int _harubee = 0;

  // intialize
  DayDetailViewmodel({required DateTime selectedDate})
    : _selectedDate = selectedDate {
    _loadDatas(targetDate: selectedDate);
  }

  // external function
  void onPressed() {
    debugPrint("DayDetailViewmodel onPressed");
  }

  void onDateSelected(DateTime date) {
    _selectedDate = date;
    _loadDatas(targetDate: date);
    notifyListeners();
  }

  // internal function
  void _loadDatas({required DateTime targetDate}) {
    final currDailyBudget = DailyBudget(date: targetDate, harubee: 0, memo: []);
    final startDate = DateTime(2024, 9, 19);
    final endDate = DateTime(2024, 10, 18);
    final fixedExpenses = [
      TransactionItem(date: DateTime(2024, 9, 20), name: "월세", price: 100000),
    ];

    _weekDayMatrix = _generateWeekMatrix(
      startDate: startDate,
      endDate: endDate,
    );
    _currDailyBudget = currDailyBudget;
    _harubee = currDailyBudget.harubee ?? 0;
    _fixedExpenses = fixedExpenses
        .where((e) => targetDate.isAtSameMomentAs(e.date))
        .toList();
    notifyListeners();
  }

  List<List<DateTime>> _generateWeekMatrix({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final weekDayList = List.generate(
      endDate.difference(startDate).inDays + 1,
      (i) => startDate.add(Duration(days: i)),
    );
    final weekDayMatrix = [
      for (int i = 0; i < weekDayList.length; i += 7)
        weekDayList.sublist(
          i,
          (i + 7 > weekDayList.length) ? weekDayList.length : i + 7,
        ),
    ];

    return weekDayMatrix;
  }
}
