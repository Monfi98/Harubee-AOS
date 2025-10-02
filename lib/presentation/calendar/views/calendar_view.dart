import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/presentation/common/widgets/navigation_back_button.dart';

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
      body: const Stack(children: []),
    );
  }
}
