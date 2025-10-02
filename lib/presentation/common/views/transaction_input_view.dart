import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harubee/presentation/common/widgets/bottom_button.dart';
import 'package:provider/provider.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/presentation/common/views/calculator_view.dart';
import 'package:harubee/presentation/common/viewmodels/transaction_input_viewmodel.dart';

class TransactionInputView extends StatelessWidget {
  const TransactionInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Container(
      height: 623,
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: HarubeeColor.bgPrimary(mode),
      ),
      child: Column(children: [TopBar(), SizedBox(height: 34), Body()]),
    );
  }
}

// * TopBar
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              overlayColor: Colors.transparent,
            ),
            child: Text(
              "취소",
              style: TextStyle(
                color: HarubeeColor.mainText(mode),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            "실제 지출 및 수입 입력",
            style: TextStyle(
              color: HarubeeColor.textPrimary(mode),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 28),
        ],
      ),
    );
  }
}

// * Body
class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    final transactionInputVM = context.watch<TransactionInputViewmodel>();
    final currentType = transactionInputVM.selectedType;

    return Expanded(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TransactionInputContainer(
                      title: "수입",
                      amount: transactionInputVM.income,
                      selected: TransactionType.income == currentType,
                      onPressed: () {
                        context
                            .read<TransactionInputViewmodel>()
                            .tapTransactionContainer(TransactionType.income);
                      },
                    ),
                    SizedBox(width: 9),
                    TransactionInputContainer(
                      title: "지출",
                      amount: transactionInputVM.expense,
                      selected: TransactionType.expense == currentType,
                      onPressed: () {
                        context
                            .read<TransactionInputViewmodel>()
                            .tapTransactionContainer(TransactionType.expense);
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 42),
                  child: BottomButton(
                    label: "저장하기",
                    backgroundColor: HarubeeColor.mainPrimary(mode),
                    foregroundColor: HarubeeColor.textFixed,
                    onPressed: () => context.pop(),
                  ),
                ),
              ],
            ),
          ),
          if (currentType != TransactionType.none)
            ChangeNotifierProvider.value(
              value: currentType == TransactionType.expense
                  ? transactionInputVM.expenseCalculatorVM
                  : transactionInputVM.incomeCalculatorVM,
              child: const CalculatorView(),
            ),
        ],
      ),
    );
  }
}

// TransactionInputContainer
class TransactionInputContainer extends StatelessWidget {
  final String title;
  final String amount;
  final bool selected;
  final VoidCallback onPressed;

  const TransactionInputContainer({
    super.key,
    required this.title,
    required this.amount,
    required this.selected,
    required this.onPressed,
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
            color: HarubeeColor.bgSecondary(mode),
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
