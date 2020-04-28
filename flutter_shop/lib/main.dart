import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/Counter.dart';
import './pages/index_page.dart';

import 'package:dio/dio.dart';
import 'package:provide/provide.dart';

void main() {
  var counter = Counter();
  var providers = Providers();

  //..语法可以返回当前的providers对象
  providers..provide(Provider<Counter>.value(counter));

  //如果有多个 类似Counter的类，可以用下边的代码
  // providers
  //   ..provide(Provider<Counter>.value(counter))
  //   ..provide(Provider<T>.value(t))
  //   ..provide(Provider<T2>.value(t2))

  runApp(
    ProviderNode(
      providers: providers,
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "百姓生活+",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}