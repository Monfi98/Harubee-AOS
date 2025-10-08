import 'package:flutter/material.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';

class TransactionInputContainer extends StatelessWidget {
  final String title;
  final String amount;
  final bool selected;
  final VoidCallback onPressed;
  final Color color;

  const TransactionInputContainer({
    super.key,
    required this.title,
    required this.amount,
    required this.selected,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 84,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: selected
                  ? HarubeeColor.mainSecondary(mode)
                  : Colors.transparent,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: HarubeeColor.textPrimary(mode),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "$amount 원",
                    style: TextStyle(
                      color: HarubeeColor.textPrimary(mode),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
