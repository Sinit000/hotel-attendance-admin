import 'package:flutter/material.dart';

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
            "Please enter number only(0-6) for working day and off day. Notes that, 0 is Sunday, 6 is Saturday,1 -> 5 Monday-Friday",
            textScaleFactor: 1.2,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Working day : ",
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
                "Off day : ",
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
