import 'package:flutter/material.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';

class TransactionInputView extends StatelessWidget {
  const TransactionInputView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider 도입
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: HarubeeColor.bgSecondary50(mode),
      ),
      child: Column(children: [TopBar()]),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider 도입
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            debugPrint("취소버튼 Pressed");
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            overlayColor: Colors.transparent,
          ),
          child: Text(
            "취소",
            style: TextStyle(
              color: HarubeeColor.mainText(mode),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          "실제 지출 및 수입 입력",
          style: TextStyle(
            color: HarubeeColor.textPrimary(mode),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 28),
      ],
    );
  }
}
