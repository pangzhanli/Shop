import 'package:flutter/material.dart';

import '../service/service_method.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: RaisedButton(
              child: Text("获取数据测试"),
              onPressed: () {
              })),
    );
  }
}
