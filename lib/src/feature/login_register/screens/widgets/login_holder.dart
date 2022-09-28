import 'package:flutter/material.dart';

Widget logoHolder() => Row(
      children: [
        Expanded(flex: 25, child: Container()),
        Expanded(
            flex: 50,
            child: AspectRatio(
                aspectRatio: 1, child: Image.asset("assets/icon/Logo_Ban.jpg")
                // child: FittedBox(
                //   child: Image.asset("assets/icon/hotel.png"),
                //   // child: Image(image: AssetImage("assets/icon/hotel.png"))
                // ),
                )),
        Expanded(flex: 25, child: Container()),
      ],
    );
