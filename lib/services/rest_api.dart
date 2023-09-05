// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter_scale/models/NewsModel.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:http/http.dart' as http;

class CallAPI {

  // กำหนด Header สำหรับการเรียกใช้งาน API
  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  // สร้างฟังก์ชันสำหรับ login
  loginAPI(data) async {
    return await http.post(
      Uri.parse(baseURLAPI+'login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // สร้างฟังก์ชันในการอ่านข่าวล่าสุด
  Future<List<NewsModel>?> getLastNews() async {
    final response = await http.get(
      Uri.parse(baseURLAPI+'lastnews'),
      headers: _setHeaders(),
    );
    // ถ้าสำเร็จให้คืนค่ากลับไปเป็น List ของ NewsModel
    if(response.body.isNotEmpty) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }

    // สร้างฟังก์ชันในการอ่านข่าวล่าสุด
  Future<List<NewsModel>?> getAllNews() async {
    final response = await http.get(
      Uri.parse(baseURLAPI+'news'),
      headers: _setHeaders(),
    );
    // ถ้าสำเร็จให้คืนค่ากลับไปเป็น List ของ NewsModel
    if(response.body.isNotEmpty) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }

}