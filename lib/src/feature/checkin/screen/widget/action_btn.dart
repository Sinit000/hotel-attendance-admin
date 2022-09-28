import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget actionButton({required String title,required Color color,  Function? onPressed }) {
  return Container(
    child: ElevatedButton(
        child: Text(title, style: TextStyle()),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: color)))),
        onPressed:onPressed as void Function()?),
  );
}
