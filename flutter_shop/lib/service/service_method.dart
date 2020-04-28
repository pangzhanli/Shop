import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import '../config/DioProxy.dart';

Future request(url,{formData}) async{
  try {
    print("开始获取数据=================");
    print("formData:$formData");

    // Dio dio = new Dio();
    Dio dio = getDio();
    dio.options.contentType = "application/x-www-form-urlencoded";

    // print("步骤1");
    //如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
    dio.options.responseType = ResponseType.plain;
    // print("步骤2");
    Response response;
    if(formData == null){
      // print("步骤3");
      response = await dio.post(servicePath[url]);
    }else{
      // print("步骤4");
      response = await dio.post(servicePath[url], data: formData);
    }
    // print("步骤5");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      print("获取数据失败");
      throw Exception("获取失败.........");
    }
  } catch (e) {
    // print("步骤6");
    print("$e");
    return print(e);
  }
}

//获取首页数据
Future getHomePageContent() async {
  try {
    print("开始获取数据=================");

    Dio dio = new Dio();
    // Dio dio = getDio();
    dio.options.contentType = "application/x-www-form-urlencoded";

    //如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
    dio.options.responseType = ResponseType.plain;
    Response response;
    var formData = {"lon": "115.02932", "lat": "35.76189"};
    response = await dio.post(servicePath["homePageContent"], data: formData);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      print("获取数据失败");
      throw Exception("获取失败.........");
    }
  } catch (e) {
    return print(e);
  }
}

//获取首页火爆专区数据
Future getBelowContent() async{
  try{
    print("开始获取数据.............");

    Dio dio = getDio();
    Response response;
    response = await dio.post(servicePath["homePageBelowContent"],data:1);

    if(response.statusCode == 200){
      return response.data;
    }else{
      print("获取数据失败");
      throw Exception("获取失败.........");
    }
  }catch(e){
    return print(e);
  }
}
