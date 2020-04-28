import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/provide/Counter.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:provide/provide.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: EdgeInsets.only(top: 200),
        child: Column(
          children: <Widget>[Number(), MyButton()],
        ),
      ),
    ));
  }
}

class Number extends StatelessWidget {
  const Number({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<Counter>(
        builder: (context, child, counter) {
          return Text("${counter.value}");
        },
      )
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        //去计算
        Provide.value<Counter>(context).incerment();
      },
      child: Text(
        "递增",
      ),
    );
  }
}
