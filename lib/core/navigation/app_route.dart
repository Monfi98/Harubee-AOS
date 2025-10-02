import 'package:flutter/material.dart';
import 'package:harubee/core/navigation/modal_page.dart';
import 'package:harubee/presentation/common/viewmodels/transaction_input_viewmodel.dart';
import 'package:harubee/presentation/common/views/transaction_input_view.dart';
import 'package:harubee/presentation/today/views/today_view.dart';
import 'package:provider/provider.dart';

enum AppRoute {
  // Route
  today('/'),
  transactionInput('/transaction_input');

  final String path;
  const AppRoute(this.path);

  // page
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
    }
  }
}
