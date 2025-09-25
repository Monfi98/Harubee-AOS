import 'package:intl/intl.dart';

extension ExpressionFormat on String {
  String get formattedExpression {
    final formatter = NumberFormat('#,###');
    final regex = RegExp(r'(\+|-)');

    return splitMapJoin(
      regex,
      onMatch: (m) => m[0]!,
      onNonMatch: (n) {
        final number = int.tryParse(n.replaceAll(',', ''));
        return number != null ? formatter.format(number) : n;
      },
    );
  }

  bool get isNumeric => double.tryParse(this) != null;
}
