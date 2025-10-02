import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBackButton extends StatelessWidget {
  final Color? color;
  final VoidCallback onPressed;

  const NavigationBackButton({super.key, this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color,
        iconSize: 25,
        padding: EdgeInsets.zero,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.chevron_back),
          Text(
            '뒤로',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
