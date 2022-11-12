import 'package:flutter/material.dart';

import '../../../../appLocalizations.dart';

class Instruction extends StatelessWidget {
  const Instruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 20, right: 20),
      padding: EdgeInsets.all(8),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppLocalizations.of(context)!.translate("pleate_enter")!}",
            textScaleFactor: 1.2,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "${AppLocalizations.of(context)!.translate("workday")!} : ",
                textScaleFactor: 1.2,
              ),
              Text(
                "1,2,3,4,5",
                textScaleFactor: 1.3,
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "${AppLocalizations.of(context)!.translate("off_day")!} : ",
                textScaleFactor: 1.2,
              ),
              Text(
                "0,6",
                textScaleFactor: 1.3,
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    );
  }
}
