import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart'as path_provider;
import 'model/hive/cart_model_hive.dart';
import 'model/hive/favourites_model_hive.dart';
import 'pages/authentication/splash_screen.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final appDocumentDirectory= await path_provider.getApplicationDocumentsDirectory();
  Hive..init(appDocumentDirectory.path)
    ..registerAdapter(CartAdapter())
    ..registerAdapter(FavouritesAdapter());
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ta', 'IN'),
        Locale('mr', 'IN'),
        Locale('kn', 'IN'),
        Locale('te', 'IN'),
        Locale('ml', 'IN'),
      ],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      useFallbackTranslations: true,
      saveLocale: true,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Color(0xff9DBB46),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.red,
        backgroundColor: Colors.black,
        fontFamily: 'Poppins-Medium',
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
     home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
