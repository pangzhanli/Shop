import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int value = 0;

  //计算
  incerment(){
    value++;

    //通知所有的监听者
    notifyListeners();
  }
  
}