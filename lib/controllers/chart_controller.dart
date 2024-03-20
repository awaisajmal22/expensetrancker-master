import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:get/get.dart';

class ChartController extends GetxController {
  final Rx<String> _transactionType = ''.obs;
  final Rx<bool> isExpense = false.obs;
  String get transactionType => _transactionType.value;

  changeTransactionType(String tt) {
    
    _transactionType.value = tt;
    isExpense.value =
        tt == Get.context!.local.income 
        // || tt == "Income" || tt == "آمدنی"
            ? false
            : true;
    
  }
}
