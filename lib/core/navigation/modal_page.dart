import 'package:flutter/material.dart';

class ModalPage<T> extends Page<T> {
  const ModalPage({required this.child});

  final Widget child;

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
    settings: this,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: child,
      );
    },
    isScrollControlled: true,
  );
}
