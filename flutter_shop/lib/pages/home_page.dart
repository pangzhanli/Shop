import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

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
            color: Colors.white,
            // height: ScreenUtil().setHeight(330),
            // height: 330,
            child: FutureBuilder(
                future:
                    getHomePageContent(), // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
                builder: (context, snapshot) {
                  //snapshot就是_calculation在时间轴上执行过程的状态快照
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return new Text('Press button to start');
                    case ConnectionState.waiting:
                      return new Text('Awaiting result...');
                    default:
                      if (snapshot.hasError) {
                        return new Text('Error: ${snapshot.error}');
                      } else {
                        // return new Text('Result: ${snapshot.data}');

                        print("已经获取到数据:${snapshot.data}");
                      }
                  }
                  if (snapshot.hasData) {
                    var data = json.decode(snapshot.data.toString());

                    //轮播
                    List<Map> swiper = (data["data"]["slides"] as List).cast();

                    //分类导航
                    List<Map> navigatorList =
                        (data["data"]["category"] as List).cast();

                    //广告
                    String picture =
                        data["data"]["advertestPicture"]["PICTURE_ADDRESS"];

                    //店长电话
                    String leaderImage =
                        data["data"]["shopInfo"]["leaderImage"];
                    String leaderPhone =
                        data["data"]["shopInfo"]["leaderPhone"];

                    //推荐
                    List<Map> recommendList =
                        (data["data"]["recommend"] as List).cast();

                    return SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            //导航组件
                            SwiperDiy(swiperDataList: swiper),
                            //底部分类组件
                            TopNavigator(navigatorList: navigatorList),
                            //广告组件
                            AdBanner(picture: picture),
                            //一键拨打店长电话
                            LeaderPhone(
                              leaderImage: leaderImage,
                              leaderPhone: leaderPhone,
                            ),
                            //推荐
                            Recommend(recommendList: recommendList)
                          ],
                        ));
                  } else {
                    return Center(
                      child: Text("暂无数据"),
                    );
                  }
                })));
  }
}

//轮播组件
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
        itemBuilder: (context, index) {
          return Image.network(this.swiperDataList[index]["image"],
              fit: BoxFit.fill);
        },
        pagination: SwiperPagination(),
      ),
    );
  }
}

//顶部导航分类组件
class TopNavigator extends StatelessWidget {
  List navigatorList;
  TopNavigator({this.navigatorList});

  //获取GridView的的ItemUI
  Widget gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print("点击了导航分类组件");
      },
      child: Column(
        children: <Widget>[
          Image.network(item["image"], width: ScreenUtil().setWidth(100)),
          Text(item["mallCategoryName"])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(300),
        padding: EdgeInsets.all(10),
        child: GridView.count(
            crossAxisCount: 5,
            children: this.navigatorList.map((value) {
              return gridViewItemUI(context, value);
            }).toList()));
  }
}

//广告Banner组件
class AdBanner extends StatelessWidget {
  String picture = "";
  AdBanner({this.picture});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: double.infinity,
        color: Colors.blue,
        height: ScreenUtil().setHeight(80),
        child: Image.network(
          this.picture,
          fit: BoxFit.fitWidth,
        ));
  }
}

//店长电话组件
class LeaderPhone extends StatelessWidget {
  String leaderImage;
  String leaderPhone;

  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: this._launchURL,
        child: Image.network(this.leaderImage),
      ),
    );
  }

  void _launchURL() async {
    //拨打电话
    String url = "tel:" + this.leaderPhone;

    //也可以打开网页
    // String url = "http://pangzhenli.top";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "不能拨打电话";
    }
  }
}

//推荐组件
class Recommend extends StatelessWidget {
  List<Map> recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  //推荐标题
  Widget _titleWidget() {
    return Container(
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 10, 5.0),
      child: Text(
        "商品推荐", 
        style: TextStyle(
          color: Colors.pink
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
      ),
    );
  }

  //推荐项
  Widget _item(index) {
    return InkWell(
        onTap: () {},
        child: Container(
          width: ScreenUtil().setWidth(250),
          height: ScreenUtil().setHeight(330),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              // color: Colors.blue,
              border: Border(
                  right: BorderSide(color: Colors.black12, width: 0.5)
              ),
          ),
          child: Column(
            children: <Widget>[
              Image.network(this.recommendList[index]["image"], fit: BoxFit.fill,),
              SizedBox(height:10),
              Text("￥${this.recommendList[index]['mallPrice']}"),
              Text(
                "￥${this.recommendList[index]["price"]}",
                style: TextStyle(
                  color: Colors.black12,
                  decoration: TextDecoration.lineThrough //中划线
                ),
              )
            ],
          ),
        ));
  }

  //整体listview
  Widget _recommendList() {
    return Container(
        height: ScreenUtil().setHeight(330),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this.recommendList.length,
            itemBuilder: (context, index) {
              return _item(index);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(400),
        child: Column(
          children: <Widget>[
            _titleWidget(),
            _recommendList(),
          ],
        ));
  }
}
