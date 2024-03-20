import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
extension LocalizationExt on BuildContext{
  AppLocalizations get local => AppLocalizations.of(this)!;
}