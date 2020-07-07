import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testdouban/constant/constant.dart';
import 'package:testdouban/page/home/home_page.dart';
import 'package:testdouban/utils/count_down_utils.dart';
import 'package:testdouban/utils/screen_utils.dart';

//开屏页面和首页共用当前页面
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //当前是否展示广告（默认展示）
  bool isShowAd = true;

  @override
  Widget build(BuildContext context) {
    //主体, Stack类似FragmeLayout，可以重叠
    return Stack(
      //内部包含的子widget
      children: <Widget>[
        //包裹的子控件是否显示
        Offstage(
          //首页的内容
          child: HomePage(),
          offstage: isShowAd, //为true时隐藏，默认隐藏
        ),
        Offstage(
          offstage: !isShowAd,
          //Splash页面的内容
          child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                //主体
                Align(
                  alignment: Alignment(0.0, 0.0), //居中
                  child: Column(
                    //一列内容
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        //圆形图片
                        radius: ScreenUtils.screenW(context) / 3,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage(Constant.ASSETS_IMG + 'home.png'),
                      ),
                      Padding(
                        //图片下面的文字
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          '这个一个参考其他项目，练习的APP',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //倒计时
                      Align(
                        alignment: Alignment(1.0, 1.0), //右上角
                        child: Container(
                          margin: EdgeInsets.only(top: 20, right: 30), //设置边距
                          padding: EdgeInsets.only(left: 10.0,top: 2.0,right: 10.0,bottom: 2.0),
                          decoration: BoxDecoration(
                              //倒计时的背景shape
                              color: Color(0xffEDEDED),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: CountDownWidget(
                            onCountDownFinishCallBack: (bool value) {
                              if (value) {
                                //停止倒计时,刷新状态
                                setState(() {
                                  isShowAd = false;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Padding(
                        //底部的图标
                        padding: EdgeInsets.only(bottom: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, //居中
                          //横向的
                          children: <Widget>[
                            Image.asset(
                              Constant.ASSETS_IMG + 'ic_launcher.png',
                              width: 50.0,
                              height: 50.0,
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  //文本
                                  'Hi,豆芽',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      )
                      //顶部打
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
