import 'package:flutter/material.dart';
import 'package:flutter_lvl5_project/Home.dart';
import 'package:flutter_lvl5_project/SignInPage.dart';
import 'package:flutter_lvl5_project/WellcomePage.dart';
import 'package:hive_flutter/hive_flutter.dart';


 
void main() async{
  print(DateTime.now());
  // initialize hive 
  await Hive.initFlutter();

  // open a box 
  await Hive.openBox("Habit_Database");
  await Hive.openBox("Box_Sign");
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      theme: ThemeData(primarySwatch: Colors.grey),
      )
    );
    
}
  