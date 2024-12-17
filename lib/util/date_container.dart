// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({
    Key? key,
    required this.date,
    required this.index, 
    // required this.list
  }) : super(key: key);
  final String date;
  final int index;
  // final List list;

String getDayOfWeek() {
  DateTime now = DateTime.now();
  List<String> days = [
    "Mo", "Tu", "We", 
    "Th", "Fr", "St", "Sn"
  ];
  return days[now.weekday - 1];
}



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: Colors.purple[200]
        ),
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getDayOfWeek()),
            Text(date)
          ],
        ),
      );
    
  }
}
