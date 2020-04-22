import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio getDio() {
  Dio _dio = Dio();
  // DefaultHttpClientAdapter adapter =
  //     _dio.httpClientAdapter = DefaultHttpClientAdapter();
  // adapter.onHttpClientCreate = (HttpClient client) {
  //   if (client == null) {
  //     client = HttpClient();
  //   }
  //   client.findProxy = (url) {
  //     return HttpClient.findProxyFromEnvironment(url, environment: {
  //       "http_proxy": 'http://10.2.116.119:8888',
  //     });
  //   };

  //   //抓Https包设置
  //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

  //   return client;
  // };

    //抓包设置代理
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
      client.findProxy = (url){
        return "PROXY 10.2.116.119:8888";
      };
      //抓Https包设置
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };

  return _dio;
}
