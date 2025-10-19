import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:harubee/core/navigation/modal_page.dart';
import 'package:harubee/presentation/calendar/viewmodels/calendar_viewmodel.dart';
import 'package:harubee/presentation/calendar/viewmodels/day_detail_viewmodel.dart';
import 'package:harubee/presentation/calendar/viewmodels/memo_edit_viewmodel.dart';
import 'package:harubee/presentation/calendar/views/calendar_view.dart';
import 'package:harubee/presentation/calendar/views/day_detail_view.dart';
import 'package:harubee/presentation/calendar/views/memo_edit_view.dart';
import 'package:harubee/presentation/common/viewmodels/transaction_input_viewmodel.dart';
import 'package:harubee/presentation/common/views/transaction_input_view.dart';
import 'package:harubee/presentation/onboarding/views/onboarding_1_view.dart';
import 'package:harubee/presentation/today/views/today_view.dart';
import 'package:provider/provider.dart';

enum AppRoute {
  onBoarding,
  today,
  transactionInput,
  calendar,
  dayDetail,
  memoEdit,
}

extension AppRouteExt on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.onBoarding:
        return '/onBoarding';
      case AppRoute.today:
        return '/today';
      case AppRoute.transactionInput:
        return '/transaction_input';
      case AppRoute.calendar:
        return '/calendar';
      case AppRoute.dayDetail:
        return '/day_detail';
      case AppRoute.memoEdit:
        return '/memo_edit';
    }
  }

  Page<void> buildPage({Object? extra}) {
    switch (this) {
      case AppRoute.onBoarding:
        return const MaterialPage(child: Onboarding1View());

      case AppRoute.today:
        return const MaterialPage(child: TodayView());

      case AppRoute.transactionInput:
        final isIncomeSelected = extra == null ? false : extra as bool;
        return ModalPage(
          child: ChangeNotifierProvider(
            create: (_) =>
                TransactionInputViewmodel(isIncomeSelected: isIncomeSelected),
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

      case AppRoute.memoEdit:
        final memo = extra as String?;
        return ModalPage(
          child: ChangeNotifierProvider(
            create: (_) => MemoEditViewmodel(memo: memo),
            child: const MemoEditView(),
          ),
        );
    }
  }
}
