import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:harubee/core/navigation/modal_page.dart';
import 'package:harubee/presentation/calendar/views/calendar_view.dart';
import 'package:harubee/presentation/common/viewmodels/transaction_input_viewmodel.dart';
import 'package:harubee/presentation/common/views/transaction_input_view.dart';
import 'package:harubee/presentation/today/views/today_view.dart';
import 'package:provider/provider.dart';

enum AppRoute { today, transactionInput, calendar }

extension AppRouteExt on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.today:
        return '/';
      case AppRoute.transactionInput:
        return '/transaction_input';
      case AppRoute.calendar:
        return '/calendar';
    }
  }

  Page<void> buildPage() {
    switch (this) {
      case AppRoute.today:
        return const MaterialPage(child: TodayView());

      case AppRoute.transactionInput:
        return ModalPage(
          child: ChangeNotifierProvider(
            create: (_) => TransactionInputViewmodel(),
            child: const TransactionInputView(),
          ),
        );

      case AppRoute.calendar:
        return const CupertinoPage(child: CalendarView());
    }
  }
}
