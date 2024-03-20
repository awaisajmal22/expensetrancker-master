import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/controllers/nav_bar_controller.dart';
import 'package:flutter_expense_tracker_app/views/screens/edit_transaction_screen.dart';
import 'package:flutter_expense_tracker_app/views/widgets/transaction_tile.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ShowTransactions extends StatelessWidget {
  ShowTransactions({Key? key}) : super(key: key);
  final _navBarController = Get.find<NavBarController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // padding: EdgeInsets.only(bottom: 40),
      itemCount: _navBarController.myTransactions.length,
      itemBuilder: (context, i) {
        final transaction = _navBarController.myTransactions[i];
        final bool isIncome =
            transaction.type == 'Income' || transaction.type == "آمدنی"
                ? true
                : false;
        final text =
            '${_navBarController.selectedCurrency.symbol}${transaction.amount}';
        final formatAmount = isIncome ? '+ $text' : '- $text';
        return transaction.date ==
                DateFormat.yMd().format(_navBarController.selectedDate)
            ? GestureDetector(
                onTap: () async {
                  await Get.to(() => EditTransactionScreen(tm: transaction));
                  _navBarController.getTransactions();
                },
                child: TransactionTile(
                    transaction: transaction,
                    formatAmount: formatAmount,
                    isIncome: isIncome),
              )
            : SizedBox();
      },
    );
  }
}
