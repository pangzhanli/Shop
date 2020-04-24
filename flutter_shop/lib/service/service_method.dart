import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import '../config/DioProxy.dart';

Future getHomePageContent() async {
  try {
    print("开始获取数据=================");

    // Dio dio = new Dio();
    Dio dio = getDio();
    dio.options.contentType = "application/x-www-form-urlencoded";

    //如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
    dio.options.responseType = ResponseType.plain;
    Response response;
    var formData = {"lon": "115.02932", "lat": "35.76189"};
    response = await dio.post(servicePath["homePageContent"], data: formData);

    if (response.statusCode == 200) {
      print("getHomepageContent:"+response.data);
      return response.data;
    } else {
      print("获取数据失败");
      throw Exception("获取失败.........");
    }
  } catch (e) {
    return print(e);
  }
}
