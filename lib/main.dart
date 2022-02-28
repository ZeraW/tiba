import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tiba/models/tiba_model.dart';
import 'package:tiba/server/database_api.dart';
import 'package:tiba/ui_screens/splash.dart';

import 'navigation_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  runApp(
      EasyLocalization(
          supportedLocales: [Locale('ar','')], path: 'assets/i18n', child: MyApp()));
}

class MyApp extends StatelessWidget {

  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'Tiba',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.key,
      initialRoute: '/',
      routes: {
        // When navigating to the "homeScreen" route, build the HomeScreen widget.
        '/': (context) => SplashScreen(),
        // When navigating to the "secondScreen" route, build the SecondScreen widget.

      },
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
