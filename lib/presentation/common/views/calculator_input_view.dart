import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';

class CalculatorInputView extends StatelessWidget {
  const CalculatorInputView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider 도입
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        color: HarubeeColor.bgPrimary(mode),
        child: Column(children: [AmountDisplay(), Keypad()]),
      ),
    );
  }
}

// *AmountDisplay
class AmountDisplay extends StatelessWidget {
  const AmountDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Provider 도입
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Container(
      height: 51,
      color: HarubeeColor.bgSecondary50(mode),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "255,000",
              style: TextStyle(
                color: HarubeeColor.textPrimary(mode),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                overlayColor: Colors.transparent,
              ),
              onPressed: () {
                debugPrint("완료 버튼");
              },
              child: Text(
                "완료",
                style: TextStyle(
                  color: HarubeeColor.textPrimary(mode),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// *Keypad
class Keypad extends StatelessWidget {
  const Keypad({super.key});

  @override
  Widget build(BuildContext context) {
    final buttons = [
      ["1", "2", "3", "AC"],
      ["4", "5", "6", "+"],
      ["7", "8", "9", "−"],
      ["0", "00", "000", "backspace"],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      child: Column(
        children: buttons.map((row) {
          return SizedBox(
            height: 60,
            child: Row(
              children: row.map((text) {
                return KeypadButton(text: text);
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// * KeypadButton
class KeypadButton extends StatelessWidget {
  const KeypadButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    final isOperations = ["AC", "+", "−", "backspace"].contains(text);

    return Expanded(
      flex: isOperations ? 6 : 5,
      child: text == "backspace"
          ? IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.delete_left_fill,
                color: HarubeeColor.mainText(mode),
                size: 24,
              ),
            )
          : TextButton(
              child: Transform.translate(
                offset: Offset(0, ["+", "−"].contains(text) ? -6 : 0),
                child: Text(
                  text,
                  style: TextStyle(
                    color: HarubeeColor.textPrimary(mode),
                    fontSize: isOperations ? (text == "AC" ? 22 : 37) : 24,
                    fontWeight: isOperations
                        ? (text == "AC" ? FontWeight.w400 : FontWeight.w200)
                        : FontWeight.w500,
                  ),
                ),
              ),
              onPressed: () {
                debugPrint(text);
              },
            ),
    );
  }
}
