import 'package:uuid/uuid.dart';

class TransactionItem {
  final String id;
  DateTime date;
  int day;
  String name;
  int price;

  TransactionItem({
    String? id,
    required this.date,
    this.day = 1,
    required this.name,
    required this.price,
  }) : id = id ?? const Uuid().v7();
}
