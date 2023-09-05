// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {

    // รับข้อมูลที่ส่งมาจากหน้า NewsItemHorizontal and NewsItemVertical
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    // print(arguments['news']);

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments['news']['topic']),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(arguments['news']['imageurl']),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(arguments['news']['topic'],
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(arguments['news']['detail'], 
              style: TextStyle(
                fontSize: 16, 
              ),
            ),
          )
        ],
      ),
    );
  }
}