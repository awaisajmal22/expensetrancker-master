import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker_app/extension/localization_extension.dart';
import 'package:flutter_expense_tracker_app/models/currency.dart';
import 'package:flutter_expense_tracker_app/models/transaction.dart';
import 'package:flutter_expense_tracker_app/providers/database_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class NavBarController extends GetxController {
  final Rx<double> totalIncome = 0.0.obs;
  final Rx<double> totalExpense = 0.0.obs;
  final Rx<double> totalBalance = 0.0.obs;
  final Rx<double> _totalForSelectedDate = 0.0.obs;
  RxBool isShowTransactionHistoryScreen = false.obs;
  final Rx<Currency> _selectedCurrency =
      Currency(currency: 'USD', symbol: '\$').obs;
  final Rx<DateTime> _selectedDate = DateTime.now().obs;
  RxInt _currencyIndex = 0.obs;

  final Rx<List<TransactionModel>> _myTransactions =
      Rx<List<TransactionModel>>([]);
  final _box = GetStorage();
  RxList<String> navBarIconList = <String>[
    'assets/icons/home.svg',
    'assets/icons/chart.svg',
    'assets/icons/setting.svg',
  ].obs;
  List<TransactionModel> get myTransactions => _myTransactions.value;
  double get totalForSelectedDate => _totalForSelectedDate.value;
  DateTime get selectedDate => _selectedDate.value;
  Currency get selectedCurrency => _selectedCurrency.value;
  int get currencyIndex => _currencyIndex.value;
  Currency get _loadCurrencyFromStorage {
    final result = _box.read('currency');

    if (result == null) {
      return Currency(currency: 'USD', symbol: '\$');
    }
    final Currency formatCurrency = Currency(
        currency: result.toString().split('|')[0],
        symbol: result.toString().split('|')[1]);

    return formatCurrency;
  }

  int get _loadCurrencyIndexFromStorage {
    final result = _box.read('currencyIndex');
    if (result != null) {
      return result;
    }
    final index = 0;
    return index;
  }

  @override
  void onInit() {
    super.onInit();
    initBannerAd();
    getTimeString;
    _selectedCurrency.value = _loadCurrencyFromStorage;
    _currencyIndex.value = _loadCurrencyIndexFromStorage;
    getTransactions();
  }

  RxInt selectedNavBarIndex = 0.obs;

  RxString greeting = ''.obs;
  int hours = DateTime.now().hour;
  getTimeString(BuildContext context) {
    if (hours >= 1 && hours <= 12) {
      greeting.value = context.local.morningTitle;
    } else if (hours >= 12 && hours <= 16) {
      greeting.value = context.local.afternoonTitle;
    } else if (hours >= 16 && hours <= 21) {
      greeting.value = context.local.eveningTitle;
    } else if (hours >= 21 && hours <= 24) {
      greeting.value = context.local.nightTitle;
    }
  }

  updateSelectedCurrency(Currency currency, int index) async {
    _selectedCurrency.value = currency;
    _currencyIndex.value = index;
    final String formatCurrency = '${currency.currency}|${currency.symbol}';
    await _box.write('currency', formatCurrency);
    await _box.write('currencyIndex', index);
  }

  getTransactions() async {
    final List<TransactionModel> transactionsFromDB = [];
    List<Map<String, dynamic>> transactions =
        await DatabaseProvider.queryTransaction();
    transactionsFromDB.assignAll(transactions.reversed
        .map((data) => TransactionModel().fromJson(data))
        .toList());
    _myTransactions.value = transactionsFromDB;
    getTotalAmountForPickedDate(transactionsFromDB);
    tracker(transactionsFromDB);
  }

  Future<int> deleteTransaction(String id) async {
    return await DatabaseProvider.deleteTransaction(id);
  }

  Future<int> updateTransaction(TransactionModel transactionModel) async {
    return await DatabaseProvider.updateTransaction(transactionModel);
  }

  updateSelectedDate(DateTime date) {
    _selectedDate.value = date;
    getTransactions();
  }

  getTotalAmountForPickedDate(List<TransactionModel> tm) {
    if (tm.isEmpty) {
      return;
    }
    double total = 0;
    for (TransactionModel transactionModel in tm) {
      if (transactionModel.date == DateFormat.yMd().format(selectedDate)) {
        if (transactionModel.type == 'Income' ||
            transactionModel.type == "آمدنی") {
          total += double.parse(transactionModel.amount!);
        } else {
          total -= double.parse(transactionModel.amount!);
        }
      }
    }
    _totalForSelectedDate.value = total;
  }

  tracker(List<TransactionModel> tm) {
    if (tm.isEmpty) {
      return;
    }
    double expense = 0;
    double income = 0;
    double balance = 0;

    for (TransactionModel transactionModel in tm) {
      if (transactionModel.type == 'Income' ||
          transactionModel.type == "آمدنی") {
        income += double.parse(transactionModel.amount!);
      } else {
        expense += double.parse(transactionModel.amount!);
      }
    }
    balance = income - expense;
    totalIncome.value = income;
    totalExpense.value = expense;
    totalBalance.value = balance;
  }

  final String adUintId = 'ca-app-pub-6484057617448956/7788341128';
  late BannerAd bannerAd;
  RxBool isAdLoaded = false.obs;
  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: adUintId,
        listener: BannerAdListener(onAdLoaded: (ad) {
          isAdLoaded.value = true;
        }, onAdFailedToLoad: (ad, err) {
          ad.dispose();
        }),
        request: AdRequest());
    bannerAd.load();
  }
}
