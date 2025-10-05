import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:harubee/core/navigation/modal_page.dart';
import 'package:harubee/presentation/calendar/viewmodels/calendar_viewmodel.dart';
import 'package:harubee/presentation/calendar/viewmodels/day_detail_viewmodel.dart';
import 'package:harubee/presentation/calendar/views/calendar_view.dart';
import 'package:harubee/presentation/calendar/views/day_detail_view.dart';
import 'package:harubee/presentation/common/viewmodels/transaction_input_viewmodel.dart';
import 'package:harubee/presentation/common/views/transaction_input_view.dart';
import 'package:harubee/presentation/today/views/today_view.dart';
import 'package:provider/provider.dart';

enum AppRoute { today, transactionInput, calendar, dayDetail }

extension AppRouteExt on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.today:
        return '/';
      case AppRoute.transactionInput:
        return 'transaction_input';
      case AppRoute.calendar:
        return 'calendar';
      case AppRoute.dayDetail:
        return 'dayDetail';
    }
  }

  String get fullPath {
    switch (this) {
      case AppRoute.today:
        return '/';
      case AppRoute.transactionInput:
        return '/transaction_input';
      case AppRoute.calendar:
        return '/calendar';
      case AppRoute.dayDetail:
        return '/calendar/dayDetail';
    }
  }

  Page<void> buildPage({Object? extra}) {
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
        return CupertinoPage(
          child: ChangeNotifierProvider(
            create: (_) => CalendarViewModel(),
            child: CalendarView(),
          ),
        );

      case AppRoute.dayDetail:
        final date = extra as DateTime;
        return CupertinoPage(
          child: ChangeNotifierProvider(
            create: (_) => DayDetailViewmodel(selectedDate: date),
            child: DayDetailView(),
          ),
        );
    }
  }
}
