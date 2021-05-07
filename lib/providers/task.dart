import 'package:flutter/cupertino.dart';
import '../models/info.dart';


  List<Info> userInfo = [
    // Info(
    //   DateTime.now().toString(),
    //   'Coding',
    //   DateTime.now(),
    //   TimeOfDay.now(),
    // ),
    // Info(
    //   DateTime.now().toString(),
    //   'Reading Books ',
    //   DateTime.now(),
    //   TimeOfDay.now(),
    // ),
  ];

  int listLength (DateTime d){
  List<Info> myList = userInfo.where((element) => element.date == d).toList();
  return myList.length;
  }

 