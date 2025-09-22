import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/design_system/images/harubee_image.dart';
import 'package:harubee/presentation/common/views/transaction_input_view.dart';
import 'package:harubee/presentation/today/widgets/rounded_hexagon_painter.dart';

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
      extendBodyBehindAppBar: true,
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
    // TODO: Provider 도입
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Stack(
      children: [
        Honeycomb(),
        Container(
          height: 64,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HarubeeColor.mainPrimary(mode),
                HarubeeColor.mainPrimary(mode).withAlpha(0), // 끝 색상
              ],
              stops: [0.6, 1],
            ),
          ),
        ),
      ],
    );
  }
}

// * Honeycomb
class Honeycomb extends StatelessWidget {
  const Honeycomb({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider 도입
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;
    final screenWidth = MediaQuery.of(context).size.width;

    // 육각형 사이의 여백
    final spacing = 15.0;
    // 가운데 육각형 기준 왼쪽 여백
    final leftPadding = 32;

    // 육각형의 넓이
    final cos30 = cos(30 * pi / 180);
    final hexagonWidth = (screenWidth - leftPadding * 2) * 8 / 9 * cos30;
    final defaultSpacing = (hexagonWidth - hexagonWidth * cos30);

    final invisibleIndex = [(0, 1), (2, 0)];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Transform.translate(
        offset: Offset(
          defaultSpacing * 2 - spacing / 2 - hexagonWidth / 2 + leftPadding,
          -20, // TODO 계산해야함
        ),
        child: Column(
          children: List.generate(3, (colIndex) {
            return Transform.translate(
              offset: Offset(
                colIndex.isOdd
                    ? (hexagonWidth + spacing - defaultSpacing) / 2
                    : 0,
                0,
              ),
              child: Row(
                children: List.generate(2, (rowIndex) {
                  return Transform.rotate(
                    angle: pi / 2,
                    child: Transform.translate(
                      offset: Offset(0, (hexagonWidth + spacing) * (1 - cos30)),
                      child: CustomPaint(
                        size: Size(
                          hexagonWidth + spacing - defaultSpacing,
                          (hexagonWidth + spacing - defaultSpacing) * cos30,
                        ),
                        painter: RoundedHexagonPainter(
                          borderRadius: hexagonWidth * 0.08,
                          width: hexagonWidth,
                          color: Colors.transparent,
                          borderWidth: 1.3,
                          borderColor:
                              invisibleIndex.contains((colIndex, rowIndex))
                              ? Colors.transparent
                              : HarubeeColor.hivePrimary(mode),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// * ForegroundLayer
class ForegroundLayer extends StatelessWidget {
  const ForegroundLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = 15.0;
    final appBarHeight = AppBar().preferredSize.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            right: 16,
            top: statusBarHeight + appBarHeight,
          ),
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
          StreakCalendar(),
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
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => const TransactionInputView(),
              );
            },
            child: Text("실제 지출 및 수입 입력하기"),
          ),
        ],
      ),
    );
  }
}

// * StreakCalendar
class StreakCalendar extends StatelessWidget {
  const StreakCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider 도입
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
