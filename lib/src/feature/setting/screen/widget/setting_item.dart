import 'package:flutter/material.dart';

Widget settingMenuTile(
    {required String? name,
    required Color iconColor,
    required String? image,
    required Function? onPressed}) {
  return Builder(builder: (context) {
    return Material(
      color: Colors.white,
      // elevation: 6,
      // shadowColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // elevation: 3,
          color: Colors.white,
          onPressed: onPressed as void Function()?,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: iconColor,
                          borderRadius: BorderRadius.circular(100)),
                      child: ImageIcon(
                        AssetImage(image!),
                        color: Colors.white,
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  name!,
                  style: TextStyle(),
                  textScaleFactor: 1.2,
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  });
}
