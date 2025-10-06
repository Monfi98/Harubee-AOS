import 'package:flutter/material.dart';
import 'package:harubee/core/utils/string_extension.dart';
import 'package:harubee/domain/models/daily_budget.dart';

class DayDetailViewmodel extends ChangeNotifier {
  // State
  DateTime get selectedDate => _selectedDate;
  String get harubee => _harubee.toString().formattedExpression;
  List<List<DateTime>> get weekDayMatrix => _weekDayMatrix;

  // internal variable
  DateTime _selectedDate;
  List<List<DateTime>> _weekDayMatrix = [];
  DailyBudget? _currDailyBudget;
  int _harubee = 0;

  // intialize
  DayDetailViewmodel({required DateTime selectedDate})
    : _selectedDate = selectedDate {
    _loadDailyData(targetDate: selectedDate);
    _generateWeekMatrix();
  }

  // external function
  void onPressed() {
    debugPrint("DayDetailViewmodel onPressed");
  }

  void onDateSelected(DateTime date) {
    _selectedDate = date;
    _loadDailyData(targetDate: date);
    notifyListeners();
  }

  // internal function
  void _loadDailyData({required DateTime targetDate}) {
    final currDailyBudget = DailyBudget(
      date: targetDate,
      harubee: 20000,
      memo: [],
    );

    _currDailyBudget = currDailyBudget;
    _harubee = currDailyBudget.harubee ?? 0;
  }

  void _generateWeekMatrix() {
    final startDate = DateTime(2024, 9, 19);
    final endDate = DateTime(2024, 10, 18);
    final weekDayList = List.generate(
      endDate.difference(startDate).inDays + 1,
      (i) => startDate.add(Duration(days: i)),
    );
    _weekDayMatrix = [
      for (int i = 0; i < weekDayList.length; i += 7)
        weekDayList.sublist(
          i,
          (i + 7 > weekDayList.length) ? weekDayList.length : i + 7,
        ),
    ];
  }
}
