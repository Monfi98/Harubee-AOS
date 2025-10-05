import 'package:uuid/uuid.dart';

class DailyBudget {
  final String id;
  final DateTime date;
  int? harubee;
  List<String> memo;
  int? expense;
  int? income;

  DailyBudget({
    String? id,
    required this.date,
    this.harubee,
    required this.memo,
    this.expense,
    this.income,
  }) : id = id ?? const Uuid().v7();
}
