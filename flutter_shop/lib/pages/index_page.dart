import 'package:flutter/material.dart';

//ios风格
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("用户中心"))
  ];

  final List<Widget> bodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  int currentIndex;
  var currentPage;

  @override
  void initState() {
    super.initState();

    this.currentIndex = 0;
    this.currentPage = this.bodies[this.currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    //默认 width : 1080px , height:1920px , allowFontScaling:false
    //目前： 设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334) , 设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: this.bottomTabs,
        currentIndex: this.currentIndex,
        onTap: (index){
          setState(() {
            this.currentIndex = index;
            this.currentPage = this.bodies[this.currentIndex];
          });
        },
      ),
      // body: this.currentPage,
      body: IndexedStack(
        index: this.currentIndex,
        children: this.bodies,
      ),
    );
  }
}
