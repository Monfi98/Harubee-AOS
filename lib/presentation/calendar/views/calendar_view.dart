import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harubee/core/utils/string_extension.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/design_system/images/harubee_image.dart';
import 'package:harubee/presentation/calendar/models/day_cell.dart';
import 'package:harubee/presentation/calendar/viewmodels/calendar_viewmodel.dart';
import 'package:harubee/presentation/common/widgets/navigation_back_button.dart';
import 'package:provider/provider.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Scaffold(
      backgroundColor: HarubeeColor.bgPrimary(mode),
      appBar: AppBar(
        backgroundColor: HarubeeColor.bgAccent(mode),
        title: Text(
          "캘린더",
          style: TextStyle(
            color: HarubeeColor.textFixed,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: NavigationBackButton(
          color: HarubeeColor.textFixed,
          onPressed: () => context.pop(),
        ),
        leadingWidth: 60,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.question_circle),
            color: HarubeeColor.textFixed,
            onPressed: () {
              debugPrint("Search tapped");
            },
          ),
        ],
      ),
      body: const Column(children: [TopSection(), CalendarSection()]),
    );
  }
}

// TopSection
class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;
    final calendarVM = context.watch<CalendarViewModel>();

    return Container(
      color: HarubeeColor.bgAccent(mode),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, 8),
              child: Text(
                calendarVM.currentYear,
                style: TextStyle(
                  color: HarubeeColor.textFixed,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => {},
                  icon: Icon(CupertinoIcons.chevron_left, size: 20),
                  color: HarubeeColor.textFixed,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "${calendarVM.startDate} - ${calendarVM.endDate}",
                    style: TextStyle(
                      color: HarubeeColor.textFixed,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(CupertinoIcons.chevron_right, size: 20),
                  color: HarubeeColor.textFixed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// CalendarSection
class CalendarSection extends StatelessWidget {
  const CalendarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [CalendarHeader(), CalendarBody()]),
    );
  }
}

// CalendarHeader
class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;
    const weekDays = ["일", "월", "화", "수", "목", "금", "토"];

    return Container(
      color: HarubeeColor.bgAccent(mode),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekDays
              .map(
                (day) => Text(
                  day,
                  style: TextStyle(
                    color: HarubeeColor.textFixed,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

// CalendarBody
class CalendarBody extends StatelessWidget {
  const CalendarBody({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;
    final calendarVM = context.watch<CalendarViewModel>();
    final calendarColCount = (calendarVM.calendarDays.length / 7)
        .ceil()
        .toInt();
    const cellHeight = 106.0;

    return Expanded(
      child: Container(
        color: HarubeeColor.bgPrimary(mode),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              Column(
                children: List.generate(
                  calendarColCount - 1,
                  (_) => Padding(
                    padding: const EdgeInsets.only(top: cellHeight),
                    child: Divider(
                      height: 1,
                      color: HarubeeColor.textPrimary10(mode),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: Table(
                  children: List.generate(calendarColCount, (weekIndex) {
                    return TableRow(
                      children: List.generate(7, (dayIndex) {
                        final index = weekIndex * 7 + dayIndex;

                        if (calendarVM.calendarDays.length <= index ||
                            calendarVM.calendarDays[index] == null) {
                          return SizedBox(height: cellHeight);
                        } else {
                          return CalendarCell(
                            cellHeight: cellHeight,
                            dayCell: calendarVM.calendarDays[index]!,
                          );
                        }
                      }),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CalendarCell
class CalendarCell extends StatelessWidget {
  final double cellHeight;
  final DayCell dayCell;

  const CalendarCell({
    super.key,
    required this.cellHeight,
    required this.dayCell,
  });

  String? get hexagonImage {
    switch (dayCell.hexagonType) {
      case HexagonType.blue:
        return HarubeeImage.hexagonBlueLight;
      case HexagonType.red:
        return HarubeeImage.hexagonRedLight;
      case HexagonType.empty:
        return HarubeeImage.hexagonEmptyLight;
      case HexagonType.none:
        return null;
    }
  }

  Color get amountColor {
    switch (dayCell.amountState) {
      case AmountState.active:
        return HarubeeColor.mainText(Appearance.light);
      case AmountState.inactive:
        return HarubeeColor.textTertiary(Appearance.light);
      case AmountState.normal:
        return HarubeeColor.textPrimary(Appearance.light);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;
    const verticalPadding = 8.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: verticalPadding),
      child: Container(
        height: cellHeight - verticalPadding * 2,
        decoration: BoxDecoration(
          color: dayCell.isToday
              ? HarubeeColor.bgSecondary50(mode)
              : Colors.transparent,
          border: Border.all(
            color: dayCell.isToday
                ? HarubeeColor.mainSecondary(mode)
                : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dayCell.day.toString(),
              style: TextStyle(
                color: HarubeeColor.textPrimary(mode),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (hexagonImage != null)
              Image.asset(hexagonImage!, width: 23, height: 23),
            Text(
              dayCell.amount.toString().formattedExpression,
              style: TextStyle(
                color: amountColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
