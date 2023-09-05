// ignore_for_file: unused_local_variable, prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // สร้าง key สำหรับ form
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้เก็บค่า username และ password
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20.0,),
                // วางรูปโลโก้
                Image.asset(
                  'assets/images/logo.png',
                  width: 100.0,
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    icon: Icon(Icons.person),
                  ),
                  // ตรวจสอบค่าที่รับเข้ามา
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  // บันทึกค่าที่รับเข้ามา
                  onSaved: (value){
                    _username = value!.toString().trim();
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    icon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty){
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  // บันทึกค่าที่รับเข้ามา
                  onSaved: (value){
                    _password = value!.toString().trim();
                  }
                ),
                SizedBox(height: 20.0,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // ตรวจสอบค่าที่รับเข้ามา
                      if(formKey.currentState!.validate()){
                        // ถ้า validate ผ่าน ให้ทำการบันทึกค่า
                        formKey.currentState!.save();

                        // print('Username: $_username');
                        // print('Password: $_password');
                        // เรียกใช้งาน API Login
                        var response = await CallAPI().loginAPI(
                          {
                            'username': _username,
                            'password': _password,
                          }
                        );

                        var body = jsonDecode(response.body);
                        // print(body);

                        // ตรวจสอบค่า status ว่าเป็น success หรือไม่
                        if(body['status'] == 'success'){

                          // สร้าง sharedPreferences instance
                          SharedPreferences pref = await SharedPreferences.getInstance();

                          // บันทึก user ลงใน local storage ด้วย shared_preferences
                          pref.setString('userID', body['data']['id']);
                          pref.setString('userName', body['data']['username']);
                          pref.setString('fullName', body['data']['fullname']);
                          pref.setString('imgProfile', body['data']['img_profile']);
                          pref.setInt('step', 2);

                          // ส่งไปหน้า dashboard
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            )
                          );
                        }else{
                          // แสดงข้อความแจ้งเตือน
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Center(child: Text('Login failed.'),),
                              backgroundColor: Colors.red,
                            )
                          );
                        }
                         

                      }
                    }, 
                    child: Text('Login', style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    )
                  ),
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: (){}, 
                      child: Text('Register'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
