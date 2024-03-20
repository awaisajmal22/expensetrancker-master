import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:get/get.dart';

final categories = [
  Get.context!.local.other,
  Get.context!.local.bills,
  Get.context!.local.clothes,
  Get.context!.local.eatingOut,
  Get.context!.local.education,
  Get.context!.local.entertainment,
  Get.context!.local.food,
  Get.context!.local.fruits,
  Get.context!.local.fuel,
  Get.context!.local.general,
  Get.context!.local.gifts,
  Get.context!.local.holiday,
  Get.context!.local.home,
  Get.context!.local.job,
  Get.context!.local.kids,
  Get.context!.local.misc,
  Get.context!.local.music,
  Get.context!.local.pets,
  Get.context!.local.shopping,
  Get.context!.local.sports,
  Get.context!.local.tickets,
  Get.context!.local.transportation,
  Get.context!.local.travel,
  Get.context!.local.wages,
];
final cashModes = [
  Get.context!.local.other,
  Get.context!.local.cash,
  Get.context!.local.creditCard,
  Get.context!.local.debitCard,
  Get.context!.local.netBanking,
  Get.context!.local.cheque,
];
