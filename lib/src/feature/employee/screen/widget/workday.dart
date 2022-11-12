
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

Widget workday(BuildContext context, {required String workday}) {
  // String workday = "0,1,2,3,4,5,6";
  List<String> list = workday.split(",");
  List<String> newList = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i] == "0") {
      newList.add("Sunday");
    }
    if (list[i] == "1") {
      newList.add("Monday");
    }
    if (list[i] == "2") {
      newList.add("Tuesday");
    }
    if (list[i] == "3") {
      newList.add("Wednesday");
    }
    if (list[i] == "4") {
      newList.add("Thursday");
    }
    if (list[i] == "5") {
      newList.add("Friday");
    }
    if (list[i] == "6") {
      newList.add("Saturday");
    }
  }
  String mystr1 = newList.join(" ");
  return Container(
    child: ListView.builder(
        itemCount: newList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Text("- "),
              Text(
                " ${newList[index]}",
                style: TextStyle(color: Colors.black),
              ),
            ],
          );
        }),
  );
}
