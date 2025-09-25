import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/presentation/common/viewmodels/calculator_viewmodel.dart';

class CalculatorInputView extends StatelessWidget {
  const CalculatorInputView({super.key});

  @override
  Widget build(BuildContext context) {
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

// * AmountDisplay
class AmountDisplay extends StatefulWidget {
  const AmountDisplay({super.key});

  @override
  State<AmountDisplay> createState() => _AmountDisplayState();
}

class _AmountDisplayState extends State<AmountDisplay> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: Selector<CalculatorViewModel, String>(
                selector: (_, vm) => vm.expression,
                builder: (_, expression, __) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scrollController.hasClients) {
                      _scrollController.jumpTo(
                        _scrollController.position.maxScrollExtent,
                      );
                    }
                  });

                  return SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          expression,
                          style: TextStyle(
                            color: HarubeeColor.textPrimary(mode),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        BlinkingCursor(color: HarubeeColor.mainPrimary(mode)),
                      ],
                    ),
                  );
                },
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
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  "완료",
                  style: TextStyle(
                    color: HarubeeColor.textPrimary(mode),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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

// * BlinkingCursor
class BlinkingCursor extends StatefulWidget {
  const BlinkingCursor({super.key, required this.color});

  final Color color;

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return false;
      setState(() => _visible = !_visible);
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      child: Container(width: 1.5, height: 16, color: widget.color),
    );
  }
}

// * Keypad
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
              padding: EdgeInsets.zero,
              constraints: BoxConstraints.expand(),
              onPressed: () {
                context.read<CalculatorViewModel>().pressKey(text);
              },
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
                context.read<CalculatorViewModel>().pressKey(text);
              },
            ),
    );
  }
}
