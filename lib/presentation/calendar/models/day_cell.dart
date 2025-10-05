class DayCell {
  String day;
  HexagonType hexagonType;
  int amount;
  AmountState amountState;
  bool isToday;

  DayCell({
    required this.day,
    required this.hexagonType,
    required this.amount,
    required this.amountState,
    required this.isToday,
  });
}

enum HexagonType { blue, red, empty, none }

enum AmountState { active, inactive, normal }
