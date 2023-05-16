import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        builder: BotToastInit(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        navigatorObservers: [BotToastNavigatorObserver()]),
  );
}
