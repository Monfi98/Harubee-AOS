enum DateFormatStyle {
  monthDay, // 9/24
  koreanFullDate, // 2024년 9월 24일 (수)
}

extension DateFormatting on DateTime {
  static const _weekdays = ["월", "화", "수", "목", "금", "토", "일"];

  String formatted(DateFormatStyle style) {
    final weekdayStr = _weekdays[weekday - 1];

    switch (style) {
      case DateFormatStyle.monthDay:
        return "$month/$day";

      case DateFormatStyle.koreanFullDate:
        return "$year년 $month월 $day일 ($weekdayStr)";
    }
  }
}
