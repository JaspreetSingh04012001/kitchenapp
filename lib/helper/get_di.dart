import 'dart:convert';

import 'package:efood_kitchen/controller/auth_controller.dart';
import 'package:efood_kitchen/controller/language_controller.dart';
import 'package:efood_kitchen/controller/localization_controller.dart';
import 'package:efood_kitchen/controller/order_controller.dart';
import 'package:efood_kitchen/controller/splash_controller.dart';
import 'package:efood_kitchen/controller/theme_controller.dart';
import 'package:efood_kitchen/data/api/api_client.dart';
import 'package:efood_kitchen/data/model/response/language_model.dart';
import 'package:efood_kitchen/data/model/response/order_details_model.dart';
import 'package:efood_kitchen/data/repository/auth_repo.dart';
import 'package:efood_kitchen/data/repository/language_repo.dart';
import 'package:efood_kitchen/data/repository/order_repo.dart';
import 'package:efood_kitchen/data/repository/splash_repo.dart';
import 'package:efood_kitchen/util/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  await Hive.initFlutter();

  Hive.registerAdapter(OldVariationAdapter());
  Hive.registerAdapter(VariationValueAdapter());
  Hive.registerAdapter(VariationAdapter());
  Hive.registerAdapter(VariationsAdapter());
  Hive.registerAdapter(TableAdapter());
  Hive.registerAdapter(ChoiceOptionsAdapter());
  Hive.registerAdapter(CategoryIdsAdapter());
  Hive.registerAdapter(ProductDetailsAdapter());
  Hive.registerAdapter(AddOnsAdapter());
  Hive.registerAdapter(DetailsAdapter());
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(OrderDetailsModelAdapter());
  await Hive.openBox<OrderDetailsModel>('OrderDetailsModel');

  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageController(sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
