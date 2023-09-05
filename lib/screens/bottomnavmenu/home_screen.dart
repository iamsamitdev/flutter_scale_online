// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/news_items_horizontal.dart';
import 'package:flutter_scale/screens/bottomnavmenu/news_items_vertical.dart';
import 'package:flutter_scale/services/rest_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('ข่าวล่าสุด', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              SizedBox(
                height: 210,
                child: FutureBuilder(
                  future: CallAPI().getLastNews(), // อ่านข้อมูลข่าวล่าสุด
                  builder: (context, AsyncSnapshot snapshot) {  
                    // ถ้ามีข้อผิดพลาดในการอ่านข้อมูล
                    if(snapshot.hasError) {
                     return Center(
                       child: Text('มีข้อผิดพลาดในการอ่านข้อมูล'),
                     );
                    // ถ้าอ่านข้อมูลได้สำเร็จ
                    } else if(snapshot.connectionState == ConnectionState.done) {
                      // สร้าง Widget แสดงรายการข่าวล่าสุด
                      return newsItemHorizontalList(snapshot.data);
                    // ถ้ากำลังอ่านข้อมูล...
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } 
                  // สร้าง Widget แสดงรายการข่าวล่าสุด
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('ข่าวทั้งหมด', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
               SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: FutureBuilder(
                  future: CallAPI().getAllNews(), // อ่านข้อมูลข่าวล่าสุด
                  builder: (context, AsyncSnapshot snapshot) {  
                    // ถ้ามีข้อผิดพลาดในการอ่านข้อมูล
                    if(snapshot.hasError) {
                     return Center(
                       child: Text('มีข้อผิดพลาดในการอ่านข้อมูล'),
                     );
                    // ถ้าอ่านข้อมูลได้สำเร็จ
                    } else if(snapshot.connectionState == ConnectionState.done) {
                      // สร้าง Widget แสดงรายการข่าวล่าสุด
                      return NewsItemVerticalList(snapshot.data);
                    // ถ้ากำลังอ่านข้อมูล...
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  } 
                  // สร้าง Widget แสดงรายการข่าวล่าสุด
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}