import 'package:flutter/material.dart';
class LeaveTypeInstruction extends StatelessWidget {
  // const Lea({ Key? key }) : super(key: key);

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
            "Please notes that scope meaning limit the number of permission for one employee ",
            textScaleFactor: 1.2,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Scope : ",
                textScaleFactor: 1.2,
              ),
              Text(
                "5",
                textScaleFactor: 1.3,
                style:
                    TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              )
            ],
          ),
          // SizedBox(
          //   height: 5,
          // ),
          // Row(
          //   children: [
          //     Text(
          //       "Off day : ",
          //       textScaleFactor: 1.2,
          //     ),
          //     Text(
          //       "0,6",
          //       textScaleFactor: 1.3,
          //       style:
          //           TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
