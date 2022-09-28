import 'package:flutter/material.dart';

class TimeInstruction extends StatelessWidget {
  const TimeInstruction({Key? key}) : super(key: key);

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
            "Please notes that Late minutes : meaning how many minutes that count to be late and for Early minutes : how many minutes that employee can leave from workplace",
            textScaleFactor: 1.2,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                "Late minutes : ",
                textScaleFactor: 1.2,
              ),
              Text(
                "10 ",
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
                "Early minutes : ",
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
        ],
      ),
    );
  }
}
