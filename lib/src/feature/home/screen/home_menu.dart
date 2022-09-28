import 'package:flutter/material.dart';

Widget homeMenuTile(
    {required String? name,
    required Color iconColor,
    required String? image,
    required Function? onPressed}) {
  return Builder(builder: (context) {
    return Material(
      color: Colors.white,
      elevation: 6,
      shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(11),
      child: Container(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11.0),
          ),
          elevation: 3,
          color: Colors.white,
          onPressed: onPressed as void Function()?,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 60,
                  height: 60,
                  child: ImageIcon(
                    AssetImage(
                      image!,
                    ),
                    color: Colors.blue,
                  )),
              // SizedBox(
              //   height: 10,
              // ),
              Text(name!, 
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 1.4)
            ],
          )),
        ),
      ),
    );
  });
}
