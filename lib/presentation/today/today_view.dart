import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:harubee/design_system/colors/harubee_colors.dart';

class TodayView extends StatelessWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {

    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Scaffold(
      backgroundColor: HarubeeColors.mainPrimary(mode),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.question_circle),
            color: HarubeeColors.textFixed,
            onPressed: () {
              debugPrint("Search tapped");
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.gear),
            color: HarubeeColors.textFixed,
            onPressed: () {
              debugPrint("Settings tapped");
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Today View Screen'),
      ),
    );
  }
}