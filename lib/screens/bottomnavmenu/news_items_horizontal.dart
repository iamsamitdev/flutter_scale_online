// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/news_detail_screen.dart';
import 'package:flutter_scale/models/NewsModel.dart';

Widget newsItemHorizontalList(List<NewsModel> news){
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: news.length,
    itemBuilder: (context, index) {

      // สร้าง object ของ NewsModel
      NewsModel newsModel = news[index];

      return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: InkWell(
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
                )
              ),
            );
          },
          child: Card(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)
                      ),
                      image: DecorationImage(
                        image: NetworkImage(newsModel.imageurl!),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      newsModel.topic.toString(), 
                      style: TextStyle(
                        fontSize: 16, fontWeight: 
                        FontWeight.bold
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                    child: Text(
                      newsModel.detail.toString(), 
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            )
          ),
        ),
      );
    }
  );
}