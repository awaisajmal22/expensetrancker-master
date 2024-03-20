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
        // print(tm.type);
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
    print(isExpense);
    if (isExpense == true) {
      if (myTransactions.any((element) =>
          element.type == 'Expense' || element.type == "اخراجات")) {
        return groupedExpenseTx.map((data) {
          print("Total Expanse ${data['amount']}");
          print("percetange ${data['amount'] / totalExpense}");
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
  return      groupedIncomeTx.map((data) {
          print("Total Income ${data['amount']}");
          print("totalPers ${data['amount'] / totalIncome}");
          return Bar(
              isExpense: isExpense,
              label: data['day'],
              totalAmount: data['amount'],
              percentage: data['amount'] / totalIncome);
        }).toList();
      } 
      else {
        return weekDays
            .map((day) => Bar(
                isExpense: isExpense,
                label: day,
                totalAmount: 0,
                percentage: 0))
            .toList();
      }
    }
    // return weekDays
    //     .map((day) => Bar(
    //         isExpense: isExpense, label: day, totalAmount: 0, percentage: 0))
    //     .toList();
  }
}
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_expense_tracker_app/constants/colors.dart';

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_expense_tracker_app/constants/mystyle.dart';

// class Chart extends StatefulWidget {
//   const Chart({super.key});

//   @override
//   State<Chart> createState() => _ChartState();
// }

// class _ChartState extends State<Chart> {
//   List<Color> gradientColors = [primaryColor, Colors.white];

//   bool showAvg = false;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.70,
//           child: Padding(
//             padding:
//                 const EdgeInsets.only(top: 24, bottom: 12, left: 10, right: 10),
//             child: LineChart(
//               mainData(),
//             ),
//           ),
//         ),
//         // SizedBox(
//         //   width: 60,
//         //   height: 34,
//         //   child: TextButton(
//         //     onPressed: () {
//         //       setState(() {
//         //         showAvg = !showAvg;
//         //       });
//         //     },
//         //     child: Text(
//         //       'avg',
//         //       style: TextStyle(
//         //         fontSize: 12,
//         //         color: showAvg ? Colors.black.withOpacity(0.5) : Colors.black,
//         //       ),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     final style = myStyle(
//         fontWeight: FontWeight.w400,
//         fontSize: 14,
//         textColor: Color(0xff666666));
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = Text('Jan', style: style);
//         break;
//       case 1:
//         text = Text('Feb', style: style);
//         break;
//       case 2:
//         text = Text('Mar', style: style);
//         break;
//       case 3:
//         text = Text('Apr', style: style);
//         break;
//       case 4:
//         text = Text('May', style: style);
//         break;
//       case 5:
//         text = Text('Jun', style: style);
//         break;
//       case 6:
//         text = Text('Jul', style: style);
//         break;
//       case 7:
//         text = Text('Aug', style: style);
//         break;
//       case 8:
//         text = Text('Sep', style: style);
//         break;
//       case 9:
//         text = Text('Oct', style: style);
//         break;
//       case 10:
//         text = Text('Nov', style: style);
//         break;
//       case 11:
//         text = Text('Dec', style: style);
//         break;
//       default:
//         text = Text('', style: style);
//         break;
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   // Widget leftTitleWidgets(double value, TitleMeta meta) {
//   //   const style = TextStyle(
//   //     fontWeight: FontWeight.bold,
//   //     fontSize: 15,
//   //   );
//   //   String text;
//   //   switch (value.toInt()) {
//   //     case 1:
//   //       text = '10K';
//   //       break;
//   //     case 3:
//   //       text = '30k';
//   //       break;
//   //     case 5:
//   //       text = '50k';
//   //       break;
//   //     default:
//   //       return Container();
//   //   }

//   //   return Text(text, style: style, textAlign: TextAlign.left);
//   // }

//   LineChartData mainData() {
//     return LineChartData(
//       lineTouchData: LineTouchData(
//         enabled: true,
//         touchTooltipData: LineTouchTooltipData(
//           tooltipBorder:
//               BorderSide(color: primaryColor.withOpacity(0.6), width: 1),
//           tooltipBgColor: Color(0xffF0F7FF),
//           tooltipRoundedRadius: 8,
//           getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//             return lineBarsSpot.map((lineBarSpot) {
//               return LineTooltipItem(
//                 lineBarSpot.y.toString(),
//                 const TextStyle(
//                   color: primaryColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             }).toList();
//           },
//         ),
//       ),
//       gridData: FlGridData(
//         show: false,
//         drawVerticalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         getDrawingHorizontalLine: (value) {
//           return const FlLine(
//             color: primaryColor,
//             strokeWidth: 1,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return const FlLine(
//             color: primaryColor,
//             strokeWidth: 1,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: false,
//             interval: 1,
//             // getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: false,
//         border: Border.all(color: primaryColor),
//       ),
//       minX: 0,
//       maxX: 11,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: const [
//             FlSpot(0, 3),
//             FlSpot(2.6, 2),
//             FlSpot(4.9, 5),
//             FlSpot(6.8, 3.1),
//             FlSpot(8, 4),
//             FlSpot(9.5, 3),
//             FlSpot(11, 4),
//           ],
//           isCurved: true,
//           gradient: LinearGradient(
//               colors: gradientColors,
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
