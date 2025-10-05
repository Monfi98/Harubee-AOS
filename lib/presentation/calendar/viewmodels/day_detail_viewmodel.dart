import 'package:flutter/material.dart';

class DayDetailViewmodel extends ChangeNotifier {
  // State

  // internal variable
  final DateTime _selectedDate;

  // intialize
  DayDetailViewmodel({required DateTime selectedDate})
    : _selectedDate = selectedDate {
    debugPrint(selectedDate.toString());
  }

  // internal function
}
