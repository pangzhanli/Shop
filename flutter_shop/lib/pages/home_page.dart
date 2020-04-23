import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot){
          print("snapshot:------\n"+snapshot.data);
          print("snapshot:------\n"+snapshot.data.toString());
          if(snapshot.hasData){
            // var data = json.decode(snapshot.data.toString());
            var data = snapshot.data;
            print("data:$data");
            // List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> swiper = List<Map>();
            swiper.add({"image":"https://gfs5.gomein.net.cn/wireless/T1YWV4BvCT1RCvBVdK_1065_390.jpg"});
            swiper.add({"image":"https://gfs8.gomein.net.cn/wireless/T1GWE4BsZv1RCvBVdK_1065_390.jpg"});
            swiper.add({"image":"https://gfs6.gomein.net.cn/wireless/T1wYD4B4Cv1RCvBVdK_1065_390.jpg"});

            return Column(
              children: <Widget>[
                SwiperDiy(swiperDataList: swiper,)
              ],
            );
          }else{
            return Text("暂无数据。。。。");
          }
        }
      ),
    );
  }
}


//首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;
  const SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: Swiper(
        itemCount: this.swiperDataList.length,
        itemBuilder: (BuildContext context, int index){
          return Image.network("${this.swiperDataList[index]['image']}");
        },
        autoplay: true,
        pagination: SwiperPagination(),
      )
    );
  }
}