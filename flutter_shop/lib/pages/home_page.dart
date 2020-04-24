import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    //默认 width : 1080px , height:1920px , allowFontScaling:false
    //目前： 设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334) , 设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
    ScreenUtil.init(context,width:750, height:1334, allowFontScaling: true);

    //设备的像素密度
    print("设备像素密度:${ScreenUtil.pixelRatio}");
    //设备的宽度
    print("设备宽度:${ScreenUtil.screenWidth}"); 
    //设备的高度
    print("设备高度:${ScreenUtil.screenHeight}");
    //底部安全距离，适用于全面屏下面有按键的
    print("底部高度:${ScreenUtil.bottomBarHeight}");
    //状态栏的高度，刘海屏会更高, 单位px
    print("状态栏高度:${ScreenUtil.statusBarHeight}");


    return Scaffold(
        appBar: AppBar(
          title: Text("生活+"),
        ),
        body: Container(
          color: Colors.purple,
          height: ScreenUtil().setHeight(330),
          // height: 330,
          child: FutureBuilder(
            future: getHomePageContent(),  // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
            builder: (context, snapshot){   //snapshot就是_calculation在时间轴上执行过程的状态快照
              switch(snapshot.connectionState){
                case ConnectionState.none:
                  return new Text('Press button to start');
                case ConnectionState.waiting:
                  return new Text('Awaiting result...');
                default: 
                  if(snapshot.hasError){
                    return new Text('Error: ${snapshot.error}');
                  }else{
                    // return new Text('Result: ${snapshot.data}');

                    print("已经获取到数据:${snapshot.data}");
                  }
              }
              if(snapshot.hasData){
                var data = json.decode(snapshot.data.toString());
                List<Map> swiper = (data["data"]["slides"] as List).cast();
                return Column(
                  children: <Widget>[
                    SwiperDiy(swiperDataList :swiper),

                  ],
                );
              }else{
                return Center(
                  child: Text("暂无数据"),
                );
              }
            }
          )
        ));
  }
}


class SwiperDiy extends StatelessWidget {

  final List swiperDataList;

  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    return Container(
       height: ScreenUtil().setHeight(280),
      // height: 280,
       child: Swiper(
         autoplay: true,
         itemCount: this.swiperDataList.length,
         itemBuilder: (context,index){
           return Image.network(this.swiperDataList[index]["image"], fit:BoxFit.fill);
         },
         pagination: SwiperPagination(),
       ),

    );
  }
}
