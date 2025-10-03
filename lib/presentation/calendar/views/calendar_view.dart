import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
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
      backgroundColor: HarubeeColor.mainPrimary(mode),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
      body: const Column(children: [Header(), Calendar()]),
    );
  }
}

// Header
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarVM = context.watch<CalendarViewModel>();

    return Padding(
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
    );
  }
}

// Calendar
class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;
    const weekDays = ["일", "월", "화", "수", "목", "금", "토"];

    return Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          SizedBox(height: 4),
          Container(
            color: HarubeeColor.bgPrimary(mode),
            child: Column(children: [Text("helloojkljl;j;ljkl;jlkjlk")]),
          ),
        ],
      ),
    );
  }
}
