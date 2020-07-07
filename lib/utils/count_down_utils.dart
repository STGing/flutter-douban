//倒计时控件

import 'dart:async';

import 'package:flutter/cupertino.dart';

class CountDownWidget extends StatefulWidget {
  //回调函数
  final onCountDownFinishCallBack;

  //构造函数中，传入一个回调
  CountDownWidget({Key key, @required this.onCountDownFinishCallBack})
      : super(key: key);

  @override
  _CountDownWidgetState createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  var _countDownTime = 10; //倒计时时间
  Timer timer; //倒计时

  @override
  void initState() {
    super.initState();
    //初始化,开始倒计时
    startCountDownTime();
  }

  ///启动倒计时
  void startCountDownTime() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //倒计时的时候，刷新界面
      setState(() {});
      //判断时间
      if (_countDownTime <= 1) {
        //时间到了,传给回调
        widget.onCountDownFinishCallBack(true);
        //结束倒计时
        stopCountDown();
        return;
      }
      _countDownTime--;
    });
  }

  ///结束倒计时
  void stopCountDown() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_countDownTime',
      style: TextStyle(fontSize: 17.0),
    );
  }
}