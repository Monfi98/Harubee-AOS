import 'package:flutter/material.dart';
import 'package:harubee/core/utils/datetime_extension.dart';
import 'package:harubee/domain/models/daily_budget.dart';
import 'package:harubee/domain/models/salary_budget.dart';
import 'package:harubee/presentation/calendar/models/day_cell.dart';

class CalendarViewModel extends ChangeNotifier {
  // State
  String get currentYear => _currSalaryBudget?.startDate.year.toString() ?? "";
  String get startDate =>
      _currSalaryBudget?.startDate.formatted(DateFormatStyle.monthDay) ?? "";
  String get endDate =>
      _currSalaryBudget?.endDate.formatted(DateFormatStyle.monthDay) ?? "";
  List<DayCell?> get calendarDays => _calendarDays;
  int get calendarColCount => (_calendarDays.length ~/ 7).ceil();

  // internal variable
  final DateTime _todayDate = DateTime.now();
  SalaryBudget? _prevSalaryBudget;
  SalaryBudget? _currSalaryBudget;
  SalaryBudget? _nextSalaryBudget;
  List<DayCell?> _calendarDays = [];

  // intialize
  CalendarViewModel() {
    _fetchSalaryBudgets();
    _generateCalendarDays();
  }

  // internal function
  void _fetchSalaryBudgets() {
    // TODO: 실제 DB들어오면 교체
    final currSalaryBudget = SalaryBudget(
      startDate: DateTime(2024, 9, 19),
      endDate: DateTime(2024, 10, 18),
      fixedIncome: 0,
      fixedExpenses: [],
      balance: 1000000,
      defaultHarubee: 25000,
      dailyBudgets: List.generate(
        50,
        (i) => DailyBudget(
          date: DateTime(2024, 9, 19 + i),
          harubee: 20000,
          memo: [],
        ),
      ),
    );

    _prevSalaryBudget = null;
    _currSalaryBudget = currSalaryBudget;
    _nextSalaryBudget = null;

    notifyListeners();
  }

  void _generateCalendarDays() {
    final nullCount = (_currSalaryBudget!.startDate.weekday % 7).toInt();
    _calendarDays = List.filled(nullCount, null, growable: true);
    _calendarDays.addAll(
      _currSalaryBudget!.dailyBudgets.map((e) {
        final harubee =
            e.harubee?.toDouble() ?? _currSalaryBudget!.defaultHarubee;

        final hexagonType = _getHexagonType(
          e.date,
          harubee,
          e.expense,
          e.income,
        );
        final (amount, state) = _getAmount(
          e.date,
          _currSalaryBudget!.defaultHarubee,
          harubee,
          e.expense,
          e.income,
        );

        return DayCell(
          day: e.date,
          hexagonType: hexagonType,
          amount: amount,
          amountState: state,
          isToday: e.date.isAtSameMomentAs(_todayDate),
        );
      }),
    );
    notifyListeners();
  }

  HexagonType _getHexagonType(
    DateTime targetDate,
    double harubee,
    int? expense,
    int? income,
  ) {
    final isFuture = targetDate.isAfter(_todayDate);
    final hasTransaction = expense != null || income != null;

    if (isFuture) {
      return HexagonType.none;
    } else {
      if (hasTransaction) {
        if (harubee >= (expense ?? 0)) {
          return HexagonType.blue;
        } else {
          return HexagonType.red;
        }
      } else {
        return HexagonType.empty;
      }
    }
  }

  (int, AmountState) _getAmount(
    DateTime targetDate,
    double defaultHarubee,
    double harubee,
    int? expense,
    int? income,
  ) {
    final isPast = targetDate.isBefore(_todayDate);
    final isToday = targetDate.isAtSameMomentAs(_todayDate);
    final isFuture = targetDate.isAfter(_todayDate);

    final hasTransaction = expense != null || income != null;

    if (isToday) {
      if (hasTransaction) {
        return (expense ?? 0, AmountState.inactive);
      } else {
        final state = defaultHarubee == harubee
            ? AmountState.normal
            : AmountState.active;
        return (harubee.toInt(), state);
      }
    }

    if (isPast) {
      if (hasTransaction) {
        return (expense ?? 0, AmountState.inactive);
      } else {
        return (0, AmountState.inactive);
      }
    }

    if (isFuture) {
      final state = defaultHarubee == harubee
          ? AmountState.normal
          : AmountState.active;
      return (harubee.toInt(), state);
    }

    return (0, AmountState.normal);
  }
}
