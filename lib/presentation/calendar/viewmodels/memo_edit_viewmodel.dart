import 'package:flutter/material.dart';

class MemoEditViewmodel extends ChangeNotifier {
  // State
  String get memo => _memo ?? "";

  // internal variable
  String? _memo;

  // initialize
  MemoEditViewmodel({required String? memo}) : _memo = memo;

  // external function
  void onChangeText({required String text}) {
    _memo = text;
    notifyListeners();
  }

  // internal function
  void saveMemo() {}
}
