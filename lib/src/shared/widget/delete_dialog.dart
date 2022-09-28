import 'package:flutter/material.dart';

Future<void> deleteDialog(
    {
    required BuildContext context,
    required Function? onPress}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: TextStyle(color: Colors.red),
          ),
          content: Text("Do want to delete this record?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No', style: TextStyle(color: Colors.red)),
            ),
            FlatButton(
              onPressed: onPress as void Function()?,
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      });
}
