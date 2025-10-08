import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';

class MemoEditView extends StatelessWidget {
  const MemoEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: HarubeeColor.bgPrimary(Appearance.light),
      ),
      child: Column(children: [TopBar()]),
    );
  }
}

// * TopBar
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              context.pop();
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
            "메모 추가",
            style: TextStyle(
              color: HarubeeColor.textPrimary(mode),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 28),
        ],
      ),
    );
  }
}
