import 'package:flutter/material.dart';

import 'package:hotle_attendnce_admin/src/utils/share/app_constant.dart';

Widget settingitem(
    {required String? name,
    required IconData? icon,
    required Function? onPressed}) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(standardBorderRadius),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        onPressed: onPressed as void Function()?,
        child: Row(children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(name!)
        ]),
      ));
}
