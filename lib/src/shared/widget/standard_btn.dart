import 'package:flutter/material.dart';

Widget standardBtn({required String title, required Function onTap}) {
  return Container(
    margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
    width: double.infinity,
    child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.lightBlue)),
        color: Colors.lightBlue,
        onPressed: () {
          onTap();
        },
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          title,
          textScaleFactor: 1.2,
          style: TextStyle(color: Colors.white),
        )),
  );
}
