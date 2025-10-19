import 'package:flutter/material.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/design_system/images/harubee_image.dart';
import 'package:harubee/presentation/common/widgets/bottom_button.dart';

class Onboarding1View extends StatelessWidget {
  const Onboarding1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: HarubeeColor.mainPrimary(Appearance.light),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Content(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 43),
            child: BottomButton(
              label: "다음으로",
              onPressed: () {},
              backgroundColor: HarubeeColor.hivePrimary(Appearance.light),
              foregroundColor: HarubeeColor.hiveText(Appearance.light),
            ),
          ),
        ],
      ),
    );
  }
}

// *Content: 글씨들이 들어있는 뷰 입니다.
class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 76),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(HarubeeImage.whiteHarubee, width: 26),
                SizedBox(width: 4),
                Text(
                  "내가 하루에",
                  style: TextStyle(
                    color: HarubeeColor.textFixed,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Text(
              "쓸 수 있는 돈은 얼마일까?",
              style: TextStyle(
                color: HarubeeColor.textFixed,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            Divider(
              height: 1,
              color: HarubeeColor.textTertiary30(Appearance.light),
            ),
            SizedBox(height: 22),
            Text(
              "하루비는 다음 수입일까지",
              style: TextStyle(
                color: HarubeeColor.textSecondaryInversion(Appearance.light),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Stack(
                  alignment: AlignmentGeometry.bottomLeft,
                  children: [
                    Text(
                      "하루에 쓸 수 있는 금액을 미리 알려주는 앱",
                      style: TextStyle(
                        color: HarubeeColor.textFixed,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 270,
                      height: 7,
                      color: HarubeeColor.mainTertiary15(Appearance.light),
                    ),
                  ],
                ),
                Text(
                  "이에요",
                  style: TextStyle(
                    color: HarubeeColor.textSecondaryInversion(
                      Appearance.light,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 74),
            Divider(
              height: 1,
              color: HarubeeColor.textTertiary30(Appearance.light),
            ),
            SizedBox(height: 22),
            Text(
              "하루비의 계산 방법은 아래와 같아요",
              style: TextStyle(
                color: HarubeeColor.textFixed,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
              decoration: BoxDecoration(
                color: HarubeeColor.mainTertiary10(Appearance.light),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "(잔액 - 예정된 고정지출) ÷ 다음 주요 수입일까지 남은 일수",
                  style: TextStyle(
                    color: HarubeeColor.textFixed,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
