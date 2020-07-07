import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testdouban/bean/home_bottom_bean.dart';
import 'package:testdouban/page/group/group_page.dart';
import 'package:testdouban/page/movie/book_audio_movie_page.dart';
import 'package:testdouban/page/shop/shop_page.dart';
import 'package:testdouban/page/user/user_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //底部按钮名称和图标的集合
  final bottomIconList = [
    HomeBottomBean('首页', 'assets/images/ic_tab_home_active.png',
        'assets/images/ic_tab_home_normal.png'),
    HomeBottomBean('书影音', 'assets/images/ic_tab_subject_active.png',
        'assets/images/ic_tab_subject_normal.png'),
    HomeBottomBean('小组', 'assets/images/ic_tab_group_active.png',
        'assets/images/ic_tab_group_normal.png'),
    HomeBottomBean('市集', 'assets/images/ic_tab_shiji_active.png',
        'assets/images/ic_tab_shiji_normal.png'),
    HomeBottomBean('我的', 'assets/images/ic_tab_profile_active.png',
        'assets/images/ic_tab_profile_normal.png')
  ];

  //底部按钮的集合
  List<BottomNavigationBarItem> bottomItemList;

  //存放页面的集合
  List<Widget> pageList;

  //当前选中页面的下标 （默认选中第0个页面)
  int currentSelectPageIndex = 0;

  @override
  void initState() {
    super.initState();
    //初始化页面集合
    if (pageList == null) {
      pageList = [
        HomePage(), //主页
        BookAudioVideoPage(), //书影音
        GroupPage(), //群组
        ShopPage(), //市集
        UserPage() //个人中心
      ];
    }
    //初始化底部按钮的集合
    if (bottomItemList == null) {
      bottomItemList = bottomIconList
          .map((e) => BottomNavigationBarItem(
              title: Text(
                e.name,
                style: TextStyle(fontSize: 10.0),
              ),
              icon: Image.asset(
                e.normalIcon,
                width: 30.0,
                height: 30.0,
              ),
              activeIcon: Image.asset(
                e.activeIcon,
                width: 30.0,
                height: 30.0,
              )))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentSelectPageIndex, children: pageList),//切换页面列表
      backgroundColor: Color.fromARGB(255, 248, 248, 248),//背景颜色
      bottomNavigationBar: BottomNavigationBar(
        items: bottomItemList,
        onTap: (int index){
          setState(() {
            currentSelectPageIndex = index;
            //这个是用来控制比较特别的shopPage中WebView不能动态隐藏的问题
//            shopPageWidget.setShowState(pages.indexOf(shopPageWidget) == _selectIndex);
          });
        },
        iconSize: 24,
        currentIndex: currentSelectPageIndex,//当前选中的页面索引
        //选中后，底部BottomNavigationBar内容的颜色(选中时，默认为主题色)（仅当type: BottomNavigationBarType.fixed,时生效）
        fixedColor: Color.fromARGB(255, 0, 188, 96),
        type: BottomNavigationBarType.fixed,
      ),

    );
  }

  //获取当前被选中的页面, Stack（层叠布局）+Offstage组合,解决状态被重置的问题
  Widget getSelectPage(int index) {
    return Offstage(
      offstage: currentSelectPageIndex != index,
      child: TickerMode(
        enabled: currentSelectPageIndex == index,
        child: pageList[index],
      ),
    );
  }
}
