import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:harubee/core/navigation/app_route.dart';
import 'package:harubee/core/utils/datetime_extension.dart';
import 'package:harubee/core/utils/string_extension.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/presentation/calendar/viewmodels/day_detail_viewmodel.dart';
import 'package:harubee/presentation/common/widgets/inner_shadow_divider.dart';
import 'package:harubee/presentation/common/widgets/navigation_back_button.dart';
import 'package:harubee/presentation/common/widgets/transaction_input_container.dart';
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
      body: Column(children: [WeeklyHeader(), Body()]),
    );
  }
}

// * Weekly Header
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
      height: 100,
      color: HarubeeColor.bgAccent(mode),
      child: PageView(
        controller: PageController(initialPage: pageIndex),
        physics: const BouncingScrollPhysics(),
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

// * WeeklyHeaderCell
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 30 : 27,
            height: isSelected ? 30 : 27,
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
            child: Padding(
              padding: EdgeInsets.only(bottom: isSelected || isToday ? 0 : 3),
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
                    fontWeight: FontWeight.w600,
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

// * Body
class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final dayDetailVM = context.watch<DayDetailViewmodel>();

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HarubeeSection(),
            InnerShadowDivider(),
            MemoSection(),
            if (dayDetailVM.fixedExpenses.isNotEmpty) ...[
              InnerShadowDivider(),
              FixedExpenseSection(),
            ],
          ],
        ),
      ),
    );
  }
}

// * HarubeeSection
class HarubeeSection extends StatelessWidget {
  const HarubeeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dayDetailVM = context.watch<DayDetailViewmodel>();

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
      child: Column(
        children: [
          Container(
            height: 53,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: HarubeeColor.textTertiary(Appearance.light),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '이 날의 하루비',
                  style: TextStyle(
                    color: HarubeeColor.textPrimary(Appearance.light),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  dayDetailVM.harubee.formattedExpression,
                  style: TextStyle(
                    color: HarubeeColor.mainText(Appearance.light),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (!dayDetailVM.selectedDate.isAfter(DateTime.now().onlyDate)) ...[
            SizedBox(height: 16),
            Row(
              children: [
                TransactionInputContainer(
                  title: "수입",
                  amount: "-",
                  selected: false,
                  onPressed: () =>
                      context.push(AppRoute.transactionInput.path, extra: true),
                  color: HarubeeColor.textTertiary30(Appearance.light),
                ),
                const SizedBox(width: 9),
                TransactionInputContainer(
                  title: "지출",
                  amount: "-",
                  selected: false,
                  onPressed: () => context.push(AppRoute.transactionInput.path),
                  color: HarubeeColor.textTertiary30(Appearance.light),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// * MemoSection
class MemoSection extends StatelessWidget {
  const MemoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dayDetailVM = context.watch<DayDetailViewmodel>();

    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '메모',
                  style: TextStyle(
                    color: HarubeeColor.textPrimary(Appearance.light),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  icon: const Icon(CupertinoIcons.plus, size: 20),
                  color: HarubeeColor.textPrimary(Appearance.light),
                  onPressed: () => context.push(AppRoute.memoEdit.path),
                ),
              ],
            ),
          ),
          dayDetailVM.memos.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 22),
                  child: Text(
                    '입력된 메모가 없어요.',
                    style: TextStyle(
                      color: HarubeeColor.textPrimary30(Appearance.light),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: dayDetailVM.memos
                        .map(
                          (e) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6),
                              Text(
                                e,
                                style: TextStyle(
                                  color: HarubeeColor.textPrimary(
                                    Appearance.light,
                                  ),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                                color: HarubeeColor.textPrimary(
                                  Appearance.light,
                                ).withValues(alpha: 0.15),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
        ],
      ),
    );
  }
}

// * FixedExpenseSection
class FixedExpenseSection extends StatelessWidget {
  const FixedExpenseSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dayDetailVM = context.watch<DayDetailViewmodel>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "예정된 고정 지출",
                style: TextStyle(
                  color: HarubeeColor.textPrimary(Appearance.light),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
              Icon(CupertinoIcons.chevron_right, size: 18),
            ],
          ),
          SizedBox(height: 10),
          Column(
            children: dayDetailVM.fixedExpenses
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.name,
                          style: TextStyle(
                            color: HarubeeColor.textPrimary(Appearance.light),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          e.price.toString().formattedExpression,
                          style: TextStyle(
                            color: HarubeeColor.warning(Appearance.light),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
