import 'package:flutter/material.dart';

import '../../appLocalizations.dart';

Future<void> deleteDialog(
    {required BuildContext context, required Function? onPress}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "${AppLocalizations.of(context)!.translate("alert")!}",
            style: TextStyle(color: Colors.red),
          ),
          content: Text(
              "${AppLocalizations.of(context)!.translate("alert_delete")!}"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("${AppLocalizations.of(context)!.translate("no")!}",
                  style: TextStyle(color: Colors.red)),
            ),
            FlatButton(
              onPressed: onPress as void Function()?,
              child: Text(
                "${AppLocalizations.of(context)!.translate("yes")!}",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      });
}
