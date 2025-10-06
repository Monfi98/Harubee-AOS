import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:harubee/core/utils/datetime_extension.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/presentation/calendar/viewmodels/day_detail_viewmodel.dart';
import 'package:harubee/presentation/common/widgets/navigation_back_button.dart';
import 'package:provider/provider.dart';

class DayDetailView extends StatelessWidget {
  const DayDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Scaffold(
      backgroundColor: HarubeeColor.bgPrimary(mode),
      appBar: AppBar(
        backgroundColor: HarubeeColor.bgAccent(mode),
        leading: NavigationBackButton(
          color: HarubeeColor.textFixed,
          onPressed: () => context.pop(),
        ),
        leadingWidth: 60,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.question_circle),
            color: HarubeeColor.textFixed,
            onPressed: () => context.read<DayDetailViewmodel>().onPressed(),
          ),
        ],
      ),
      body: Column(children: [WeeklyHeader()]),
    );
  }
}

// Weekly Header
class WeeklyHeader extends StatelessWidget {
  const WeeklyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;
    final screenWidth = MediaQuery.of(context).size.width;
    const sidePadding = 22.0;
    final cellWidth = (screenWidth - sidePadding * 2) / 7;
    final dayDetailVM = context.watch<DayDetailViewmodel>();
    final pageIndex = dayDetailVM.weekDayMatrix.indexWhere(
      (week) => week.contains(dayDetailVM.selectedDate),
    );

    return Container(
      height: 98,
      color: HarubeeColor.bgAccent(mode),
      child: PageView(
        controller: PageController(initialPage: pageIndex),
        children: [
          for (final weekDayList in dayDetailVM.weekDayMatrix)
            Padding(
              padding: const EdgeInsets.only(
                left: sidePadding,
                right: sidePadding,
                top: 30,
                bottom: 12,
              ),
              child: Row(
                children: [
                  for (final day in weekDayList)
                    WeeklyHeaderCell(cellWidth: cellWidth, day: day),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class WeeklyHeaderCell extends StatelessWidget {
  const WeeklyHeaderCell({
    super.key,
    required this.cellWidth,
    required this.day,
  });

  final double cellWidth;
  final DateTime day;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;
    final dayDetailVM = context.watch<DayDetailViewmodel>();
    final isSelected = day == dayDetailVM.selectedDate;
    final isToday = day == DateTime.now().onlyDate;
    const weekdays = ["월", "화", "수", "목", "금", "토", "일"];

    return SizedBox(
      width: cellWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            weekdays[day.weekday - 1],
            style: TextStyle(
              color: HarubeeColor.textFixed,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: isSelected ? 0 : 3.1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: isSelected ? 30 : 25,
              height: isSelected ? 30 : 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? HarubeeColor.bgPrimary(mode)
                    : Colors.transparent,
                border: Border.all(
                  color: isToday ? HarubeeColor.textFixed : Colors.transparent,
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () =>
                    context.read<DayDetailViewmodel>().onDateSelected(day),
                child: Text(
                  day.day.toString(),
                  style: TextStyle(
                    color: isSelected
                        ? HarubeeColor.dayText(mode)
                        : HarubeeColor.textFixed,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
