// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/provider/locale_provider.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
// import 'package:flutter_scale/screens/welcome/welcome_screen.dart';
import 'package:flutter_scale/themes/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

var initScreen;
var locale;

void main() async {
  // ต้องเรียกใช้ ensureInitialized() ก่อนเพื่อให้ทำงานก่อน runApp()
  WidgetsFlutterBinding.ensureInitialized();

  // สร้าง sharedPreferences instance
  SharedPreferences pref = await SharedPreferences.getInstance();

  // เช็คว่ามี step ที่เคยล็อกอินแล้วหรือยัง
  if (pref.getInt('step') == null) {
    // ถ้ายังไม่ได้ login ให้ไปที่หน้า login
    initScreen = LoginScreen();
  } else if (pref.getInt('step') == 2) {
    // ถ้า login แล้วให้ไปที่หน้า dashboard
    initScreen = DashboardScreen();
  }

  // Set default locale
  String? languageCode = pref.getString('languageCode');
  locale = Locale(languageCode ?? 'en');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(locale),
        )
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, locale, child) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale.locale,
            debugShowCheckedModeBanner: false,
            title: 'Flutter Scale',
            theme: AppTheme.lightTheme,
            home: initScreen,
          );
        },
      ),
    );
  }
}
