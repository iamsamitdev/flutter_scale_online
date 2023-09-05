// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_scale/provider/locale_provider.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // การอ่านข้อมูล user จาก local storage ด้วย shared_preferences
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(
            shrinkWrap: true, // กำหนดให้ ListView หดตามข้อมูล
            children: [
              _buildHeader(),
              _buildListMenu(),
            ],
          )
        ]
      ),
    );
  }

  // _buildHeader สร้างส่วนหัวของหน้าจอ
  Widget _buildHeader() {
    return Container(
      height: 230,
      decoration: BoxDecoration(color: primaryDark),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.hello,
            style: TextStyle(
              color: Colors.white, 
              fontSize: 20,
              ),
            ),
          SizedBox(height: 10),
          _imgProfile == '' ?
            Center(
              child: CircularProgressIndicator()
          ) 
          :
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(baseURLImage+'profile/'+_imgProfile),
          ),
          SizedBox(height: 10),
          Text(
            _fullname.toString(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            _username.toString(),
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // _buildListMenu สร้างเมนู
  Widget _buildListMenu() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text(AppLocalizations.of(context)!.menu_account),
          trailing: Icon(Icons.arrow_forward_ios, size: 16,),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text(AppLocalizations.of(context)!.menu_changepass),
          trailing: Icon(Icons.arrow_forward_ios, size: 16,),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text(AppLocalizations.of(context)!.menu_changelang),
          trailing: Icon(Icons.arrow_forward_ios, size: 16,),
          onTap: (){
            // สร้าง alert dialog เพื่อเลือกภาษา
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.label_chooselang),
                  content: SingleChildScrollView(
                    child: Consumer<LocaleProvider>(
                      builder: (context, provider, child) {
                        return ListBody(
                          children: [
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('ไทย'),
                              ),
                              onTap: (){
                                // เปลี่ยนภาษาเป็นภาษาไทย
                                provider.changeLocale(const Locale('th'));
                                // ปิด alert dialog
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('English'),
                              ),
                              onTap: (){
                                // เปลี่ยนภาษาเป็นภาษาอังกฤษ
                                provider.changeLocale(const Locale('en'));
                                // ปิด alert dialog
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ); 
              }
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_mail),
          title: Text(AppLocalizations.of(context)!.menu_contact),
          trailing: Icon(Icons.arrow_forward_ios, size: 16,),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(AppLocalizations.of(context)!.menu_setting),
          trailing: Icon(Icons.arrow_forward_ios, size: 16,),
          onTap: (){},
        ),
         ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text(AppLocalizations.of(context)!.menu_logout),
          trailing: Icon(Icons.arrow_forward_ios, size: 16,),
          onTap: (){},
        ),
      ],
    );
  }

}