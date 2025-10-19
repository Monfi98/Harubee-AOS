import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/presentation/calendar/viewmodels/memo_edit_viewmodel.dart';
import 'package:harubee/presentation/common/views/float_placeholder_textfield.dart';
import 'package:harubee/presentation/common/widgets/bottom_button.dart';
import 'package:provider/provider.dart';

class MemoEditView extends StatelessWidget {
  const MemoEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 203,
      padding: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: HarubeeColor.bgPrimary(Appearance.light),
      ),
      child: Column(children: [TopBar(), Body()]),
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

// * Body
class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final memoMaxLength = 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextLimitIndicator(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FloatedPlaceholderTextField(
            placeholder: "메모",
            onChanged: (text) {
              if (text.length > memoMaxLength) return;
              context.read<MemoEditViewmodel>().onChangeText(text: text);
            },
            maxLength: memoMaxLength,
          ),
        ),
        SizedBox(height: 24),
        BottomButton(
          label: "저장하기",
          backgroundColor: HarubeeColor.mainPrimary(Appearance.light),
          foregroundColor: HarubeeColor.textFixed,
          onPressed: () {},
          isSharpCornered: true,
        ),
      ],
    );
  }
}

class TextLimitIndicator extends StatelessWidget {
  const TextLimitIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final memoEditVM = context.watch<MemoEditViewmodel>();

    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 17),
      child: Text(
        "(${memoEditVM.memo.length}/20)",
        style: TextStyle(
          color: HarubeeColor.textPrimary(Appearance.light),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
