// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/home_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/notification_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/profile_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/report_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/setting_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // การอ่านข้อมูล user จาก local storage ด้วย shared_preferences ---------------
  // สร้าง instance ของ shared_preferences
  late SharedPreferences pref;

  // สร้างตัวแปรไว้เก็บข้อมูล user
  String _username = '';
  String _fullname = '';
  String _imgProfile = '';

  // สร้างฟังก์ชันสำหรับอ่านข้อมูล user จาก local storage
  getUser() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      _username = pref.getString('userName')!;
      _fullname = pref.getString('fullName')!;
      _imgProfile = pref.getString('imgProfile')!;
    });
  }

  // ฟังก์ชัน initState จะถูกเรียกใช้งานก่อนการสร้างหน้าจอ
  @override
  void initState() {
    super.initState();
    // เรียกใช้ฟังก์ชัน getUser เมื่อทำการเปิดหน้าจอ
    getUser();
  }
  // -------------------------------------------------------------------

  // ส่วนของการโหลด bottomnav menu ------------------------------
  // สร้างตัวแปรสำหรับเก็บ index ของ bottom navigation menu
  int _currentIndex = 0;

  // สร้างตัวแปรเก็บ title ของ bottom navigation menu
  String _title = 'Flutter Scale';

  // สร้าง list ของ bottom navigation menu
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  // สร้างฟังก์ชันสำหรับเปลี่ยนหน้า bottom navigation menu
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      switch(_currentIndex) {
        case 0: _title = AppLocalizations.of(context)!.menu_home; break;
        case 1: _title = AppLocalizations.of(context)!.menu_report; break;
        case 2: _title = AppLocalizations.of(context)!.menu_notification; break;
        case 3: _title = AppLocalizations.of(context)!.menu_setting; break;
        case 4: _title = AppLocalizations.of(context)!.menu_profile; break;
        default: _title = 'Flutter Scale'; break;
      }
    });
  }

  // --------------------------------------------------------------


  // สร้างฟังก์ชัน logout -----------------------------------------
  logout() async {
    // clear ค่าใน SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();

    // กลับไปหน้า login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
  // -----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title'),
      ),
      drawer: Drawer(
        // backgroundColor: Colors.green,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true, // ทำให้ ListView ไม่เกินขนาด
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('$_fullname'), 
                  accountEmail: Text('$_username'),
                  currentAccountPicture: 
                  _imgProfile == '' ?
                    Center(
                      child: CircularProgressIndicator()
                    ) 
                  :
                  CircleAvatar(
                    backgroundImage: NetworkImage(baseURLImage+'profile/'+_imgProfile),
                  ),
                  otherAccountsPictures: [
                    _imgProfile == '' ?
                      Center(
                        child: CircularProgressIndicator()
                      ) 
                    :
                    CircleAvatar(
                      backgroundImage: NetworkImage(baseURLImage+'profile/'+_imgProfile),
                    ),
                    _imgProfile == '' ?
                      Center(
                        child: CircularProgressIndicator()
                      ) 
                    :
                    CircleAvatar(
                      backgroundImage: NetworkImage(baseURLImage+'profile/'+_imgProfile),
                    ),
                  ],
                )
              ],
            ),
            // Menu
            ListTile(
              leading: Icon(Icons.info),
              title: Text(AppLocalizations.of(context)!.menu_about, style: TextStyle(fontSize: 16),),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text(AppLocalizations.of(context)!.menu_info, style: TextStyle(fontSize: 16),),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(AppLocalizations.of(context)!.menu_contact, style: TextStyle(fontSize: 16),),
              onTap: () {},
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text(AppLocalizations.of(context)!.menu_logout, style: TextStyle(fontSize: 16),),
                    onTap: logout,
                  ),
                ],
              )
            )
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          onTabTapped(index);
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.menu_home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: AppLocalizations.of(context)!.menu_report,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: AppLocalizations.of(context)!.menu_notification,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: AppLocalizations.of(context)!.menu_setting,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!.menu_profile,
          ),
        ]
      ),
    );
  }
}