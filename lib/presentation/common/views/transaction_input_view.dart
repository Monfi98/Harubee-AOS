import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:harubee/design_system/colors/harubee_color.dart';
import 'package:harubee/presentation/common/views/calculator_input_view.dart';
import 'package:harubee/presentation/common/viewmodels/transaction_input_viewmodel.dart';

class TransactionInputView extends StatelessWidget {
  const TransactionInputView({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Container(
      width: double.infinity,
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
              Navigator.pop(context);
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
                      onPressed: () {
                        debugPrint("수입 입력");
                      },
                    ),
                    SizedBox(width: 9),
                    TransactionInputContainer(
                      title: "지출",
                      amount: transactionInputVM.expense,
                      onPressed: () {
                        debugPrint("지출 입력");
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 42),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.fromHeight(60),
                      backgroundColor: HarubeeColor.mainPrimary(mode),
                      foregroundColor: HarubeeColor.textFixed,
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {
                      debugPrint("");
                    },
                    child: Text("저장하기"),
                  ),
                ),
              ],
            ),
          ),
          ChangeNotifierProvider.value(
            value: transactionInputVM.calculatorVM,
            child: const CalculatorInputView(),
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
  final VoidCallback onPressed;

  const TransactionInputContainer({
    super.key,
    required this.title,
    required this.amount,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final mode = Theme.of(context).brightness == Brightness.dark
        ? Appearance.dark
        : Appearance.light;

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: HarubeeColor.bgSecondary(mode),
          border: Border.all(color: HarubeeColor.mainSecondary(mode), width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
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
              child: Text(
                "$amount 원",
                style: TextStyle(
                  color: HarubeeColor.textPrimary(mode),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
