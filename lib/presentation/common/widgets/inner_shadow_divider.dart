import 'package:flutter/material.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';

class InnerShadowDivider extends StatelessWidget {
  const InnerShadowDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      decoration: BoxDecoration(
        color: HarubeeColor.textPrimary5(Appearance.light),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 3,
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
