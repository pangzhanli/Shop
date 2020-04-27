import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../service/service_method.dart';
import 'dart:convert';


class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  EasyRefreshController _controller = EasyRefreshController();

  int _count =0;

  List<Map> dataArr = [];
  var pageIndex =0;//页数
  var count =10;//每页10条

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("上拉加载更多"),
      ),
      body: EasyRefresh(
        // controller: _controller,
        // firstRefresh: true,
        // firstRefreshWidget: Container(
        //   color: Colors.blue,
        //   width: 400,
        //   height: 400,
        //   child: Text("加载中....."),
        // ),
        // header: ClassicalHeader(),
        footer: ClassicalFooter(),
        child: ListView.builder(
          itemCount: _count,
          itemExtent: 50.0,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              title: Text("$index"),
            );
          }
        ),
        // onRefresh: () async{
        //   print("下拉刷新-----------------");
        //   refreshData();
        // },
        onLoad: () async{
          print("上拉加载-----------------");
          getMoreData();
        },
      ),
    );
  }

  void refreshData() async {
    var formData = {"page": 0};
    await request("homePageBelowContent", formData).then((value) {
      var data = json.decode(value.toString());
      List<Map> newGoodsList = (data["data"] as List).cast();
      this.dataArr.addAll(newGoodsList);

      setState(() {
        _count = dataArr.length;
        _controller.finishLoad(noMore: _count >= 100);
      });
      
    });
  }

  void getMoreData() async{
    var formData = {"page": 0};
    await request("homePageBelowContent", formData).then((value) {
      var data = json.decode(value.toString());
      List<Map> newGoodsList = (data["data"] as List).cast();
      this.dataArr.addAll(newGoodsList);

      setState(() {
        _count = dataArr.length;
        print("加载更多条数"+_count.toString());
        _controller.finishLoad(noMore: _count >= 100);

      });
      
    });
  }
}
