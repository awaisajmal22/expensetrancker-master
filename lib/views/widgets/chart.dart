import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/controllers/language_controller.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:flutter_expense_tracker_app/views/widgets/chart_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<TransactionModel> myTransactions;
  final _languageTransalation = Get.put(LanguageController());
  final bool isExpense;
  Chart({Key? key, required this.isExpense, required this.myTransactions})
      : super(key: key);

  List<String> get weekDays {
    return List.generate(7, (i) {
      final weekDay = DateTime.now().subtract(Duration(days: i));
      return DateFormat.E(_languageTransalation.selectedLanguageCode)
          .format(weekDay)[0];
    }).reversed.toList();
  }

  List<Map<String, dynamic>> get groupedExpenseTx {
    return List.generate(7, (i) {
      final weekDay = DateTime.now().subtract(Duration(days: i));

      double totalSum = 0;
      for (var tm in myTransactions) {
      //   List<String> dateParts = tm.date!.split('/');
      // int month = int.parse(dateParts[0]);
      // int day = int.parse(dateParts[1]);
      // int year = int.parse(dateParts[2]);
        if (tm.date == DateFormat.yMd().format(weekDay)) {
          if (tm.type == 'Expense' || tm.type == "اخراجات") {
            totalSum += double.parse(tm.amount!);
          }
        }
      }

      return {
        'day': DateFormat.E(_languageTransalation.selectedLanguageCode)
            .format(weekDay)[0],
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  List<Map<String, dynamic>> get groupedIncomeTx {
    return List.generate(7, (i) {
      final weekDay = DateTime.now().subtract(Duration(days: i));

      double totalSum = 0;
      for (var tm in myTransactions) {
        if (tm.date == DateFormat.yMd().format(weekDay)) {
          if (tm.type == 'Income' || tm.type == "آمدنی") {
            totalSum += double.parse(tm.amount!);
          }
        }
      }

      return {
        'day': DateFormat.E(_languageTransalation.selectedLanguageCode)
            .format(weekDay)[0],
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalExpense {
    return groupedExpenseTx.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  double get totalIncome {
    return groupedIncomeTx.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("isExpanse Value $isExpense");
    return Row(
      children: _displayChart(),
    );
  }

  List<Bar> _displayChart() {

    if (isExpense == true) {
      if (myTransactions.any((element) =>
          element.type == 'Expense' || element.type == "اخراجات")) {
        return groupedExpenseTx.map((data) {

          return Bar(
              isExpense: isExpense,
              label: data['day'],
              totalAmount: data['amount'],
              percentage: data['amount'] / totalExpense);
        }).toList();
      } else {
        return weekDays
            .map((day) =>
                Bar(isExpense: true, label: day, totalAmount: 0, percentage: 0))
            .toList();
      }
    } else {
      if (myTransactions.any(
          (element) => element.type == 'Income' || element.type == "آمدنی")) {
        return groupedIncomeTx.map((data) {
          print("Total Income ${data['amount']}");
          print("totalPers ${data['amount'] / totalIncome}");
          return Bar(
              isExpense: isExpense,
              label: data['day'],
              totalAmount: data['amount'],
              percentage: data['amount'] / totalIncome);
        }).toList();
      } else {
        return weekDays
            .map((day) => Bar(
                isExpense: isExpense,
                label: day,
                totalAmount: 0,
                percentage: 0))
            .toList();
      }
    }

  }
}

// class Chart extends StatelessWidget {
//   final List<TransactionModel> myTransactions;
//   final _languageTransalation = Get.put(LanguageController());
//   final bool isExpense;
//   double _totalSpending = 0.0;

//   Chart({required this.myTransactions, required this.isExpense});

//   List<Map<String, Object>> get groupedTransactionValues {
//     final today = DateTime.now();
//     List<double> weekSums = List<double>.filled(7, 0);

//     for (TransactionModel txn in myTransactions) {
//       List<String> dateParts = txn.date!.split('/');
//       int month = int.parse(dateParts[0]);
//       int day = int.parse(dateParts[1]);
//       int year = int.parse(dateParts[2]);
//       weekSums[DateTime(year, month, day).weekday - 1] +=
//           double.parse(txn.amount!);
//       _totalSpending += double.parse(txn.amount!);
//     }

//     return List.generate(7, (index) {
//       final dayOfPastWeek = today.subtract(
//         Duration(days: index),
//       );

//       return {
//         'day': DateFormat.E(_languageTransalation.selectedLanguageCode)
//             .format(dayOfPastWeek)[0],
//         'amount': weekSums[dayOfPastWeek.weekday - 1],
//       };
//     }).reversed.toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 6,
//       margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: groupedTransactionValues.map((value) {
//             return Flexible(
//               fit: FlexFit.tight,
//               child: Bar(
//                 isExpense: isExpense,
//                 label: value['day'].toString(),
//                 totalAmount: double.parse(value['amount'].toString()),
//                 percentage: _totalSpending == 0.0
//                     ? 0.0
//                     : (value['amount'] as double) / _totalSpending,
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
