import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocaleProvider extends ChangeNotifier {

  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  // Shared Preferences
  SharedPreferences? _pref;

  // Constructor
  LocaleProvider(Locale locale) {
    _locale = locale;
  }

  // ฟังก์ชันเปลี่ยนภาษา
  void changeLocale(Locale newLocale) async {

    // สร้าง instance ของ shared_preferences
    _pref = await SharedPreferences.getInstance();

    // บันทึกภาษาที่เลือกลง shared_preferences
    await _pref!.setString('languageCode', newLocale.languageCode);
    
    _locale = newLocale; // กำหนดภาษาใหม่
    notifyListeners(); // แจ้งเตือนการเปลี่ยนภาษา

  }

}