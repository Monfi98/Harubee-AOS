import 'package:harubee/domain/models/daily_budget.dart';
import 'package:harubee/domain/models/transaction_item.dart';
import 'package:uuid/uuid.dart';

class SalaryBudget {
  static const namespace = "salary";

  final String id;
  final DateTime startDate;
  final DateTime endDate;
  int fixedIncome;
  List<TransactionItem> fixedExpenses;
  int balance;
  double defaultHarubee;
  List<DailyBudget> dailyBudgets;

  SalaryBudget({
    String? id,
    required this.startDate,
    required this.endDate,
    required this.fixedIncome,
    required this.fixedExpenses,
    required this.balance,
    required this.defaultHarubee,
    required this.dailyBudgets,
  }) : id = id ?? const Uuid().v5(namespace, startDate.toIso8601String());
}
