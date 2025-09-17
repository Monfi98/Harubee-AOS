import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/design_system/images/harubee_image.dart';

// * TodayView
class TodayView extends StatelessWidget {
  const TodayView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider 도입
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Scaffold(
      backgroundColor: HarubeeColor.mainPrimary(mode),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.question_circle),
            color: HarubeeColor.textFixed,
            onPressed: () {
              debugPrint("Search tapped");
            },
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.gear),
            color: HarubeeColor.textFixed,
            onPressed: () {
              debugPrint("Settings tapped");
            },
          ),
        ],
      ),
      body: const Stack(children: [BackgroundLayer(), ForegroundLayer()]),
    );
  }
}

// * BackgroundLayer
class BackgroundLayer extends StatelessWidget {
  const BackgroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: double.infinity, child: Text("BackgroundLayer"));
  }
}

// * ForegroundLayer
class ForegroundLayer extends StatelessWidget {
  const ForegroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text(
            "2024년 9월 24일 (수)",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: HarubeeColor.textFixed,
            ),
          ),
        ),
        FooterSection(),
      ],
    );
  }
}

// * FooterSection
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider 도입
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Container(
      height: 230,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 14, bottom: 9),
      color: HarubeeColor.mainBgPrimary(mode),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "캘린더",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: HarubeeColor.textPrimary(mode),
                ),
              ),
              Icon(CupertinoIcons.chevron_forward, size: 16),
            ],
          ),
          SizedBox(height: 8),
          StreakCalender(),
          SizedBox(height: 16),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size.fromHeight(60),
              backgroundColor: HarubeeColor.mainPrimary(mode),
              foregroundColor: HarubeeColor.textFixed,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onPressed: () {
              debugPrint("Bottom Button 눌림");
            },
            child: Text("실제 지출 및 수입 입력하기"),
          ),
        ],
      ),
    );
  }
}

// * StreakCalendar
class StreakCalender extends StatelessWidget {
  const StreakCalender({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    final screenWidth = MediaQuery.of(context).size.width;
    final (sidePadding, todayPadding) = (16, 5);
    final cellWidth = (screenWidth - sidePadding * 2 - todayPadding * 2) / 7;

    final flexValues = [3, 1, 3];

    return InkWell(
      onTap: () {
        debugPrint("Streak Tapped!");
      },
      child: SizedBox(
        height: 72,
        child: Stack(
          children: [
            Row(
              children: List.generate(flexValues.length * 2 - 1, (index) {
                if (index.isOdd) {
                  return const SizedBox(width: 8);
                } else {
                  return Expanded(
                    flex: flexValues[index ~/ 2],
                    child: Container(
                      decoration: BoxDecoration(
                        color: HarubeeColor.bgSecondary50(mode),
                        border: Border.all(
                          color: index == 2
                              ? HarubeeColor.mainSecondary(mode)
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }
              }),
            ),
            Row(
              children: List.generate(7, (index) {
                final isToday = index == 3;

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isToday ? 5 : 0,
                    vertical: 10.0,
                  ),
                  child: SizedBox(
                    width: cellWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isToday ? "오늘" : "19(일)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            height: 1,
                            color: isToday
                                ? HarubeeColor.mainText(mode)
                                : HarubeeColor.textSecondary(mode),
                          ),
                        ),
                        Image.asset(
                          HarubeeImage.hexagonEmptyLight,
                          width: 23,
                          height: 23,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
