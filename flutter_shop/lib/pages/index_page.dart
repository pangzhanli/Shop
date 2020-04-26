import 'package:flutter/material.dart';

//ios风格
import 'package:flutter/cupertino.dart';

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
