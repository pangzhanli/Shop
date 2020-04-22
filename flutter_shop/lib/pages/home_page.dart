import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_shop/config/httpHeader.dart';
import '../config/DioProxy.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String showText = "未获取数据";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("伪造请求头")
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("获取数据"),
                onPressed: this._jike,
              ),
              Text(showText)
            ],
          ),
        ),
      ),
    );
  }

  void _jike(){
    print("开始获取数据........................");

    getHttpData().then((value){
      setState(() {
        // showText = value['data'].toString();
      });
    });
  }

  Future getHttpData() async{
    try{
      Response response;
      // Dio dio = getDio();
      Dio dio = Dio();
      dio.options.headers = httpHeader;

      var params = {
        "page":"lecturev2"
      };

      response = await dio.post("https://time.geekbang.org/serv/v2/explore/all", data: params);
      print("已经获取到数据");
      print(response.data);
      return response.data;
    }catch(e){
      return e;
    }
  }
}