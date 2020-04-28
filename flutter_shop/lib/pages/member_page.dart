import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/Counter.dart';
import 'package:provide/provide.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Provide<Counter>(
          builder: (context,child,counter){
            return Text("${counter.value}");
          }
        ),
      ),
    );
  }
}