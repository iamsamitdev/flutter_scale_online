// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/news_detail_screen.dart';
import 'package:flutter_scale/models/NewsModel.dart';

Widget NewsItemVerticalList(List<NewsModel> news) {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: 10,
    itemBuilder: (context, index) {

      // สร้าง object ของ NewsModel
      NewsModel newsModel = news[index];

      return ListTile(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetail(),
              // ส่งข้อมูลไปยังหน้า NewsDetail
              settings: RouteSettings(
                arguments: {
                  'news': newsModel.toJson(),
                }
              ),
            ),
          );
        },
        leading: Image.network(newsModel.imageurl!),
        title: Text(
          newsModel.topic.toString(), 
          style: TextStyle(
            fontSize: 16, fontWeight: 
            FontWeight.bold
          ),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          newsModel.detail.toString(), 
          style: TextStyle(
            fontSize: 14,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
  );
}