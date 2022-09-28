import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

// Color color2 = HexColor("#b74093");

Widget outOfStockTile() {
  return GestureDetector(
    onTap: () {
      // Navigator.pushNamed(context, outOfStock);
    },
    child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        // height: double.infinity,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: new LinearGradient(
              colors: [
                HexColor('#afaaff'),
                // Colors.purple[300],
                HexColor('#afaaff'),
                HexColor('#afaaff'),
                HexColor('#f7ccff'),
                // Colors.pink[50],
                // Colors.pink[100],
                // Colors.pink[200],
                // Colors.red[200]
              ],
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Expanded(
                  child: FittedBox(
                      child: Text(
                    '3',
                    // state.productList.length.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red[900]),
                  )),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Available room',
                  // AppLocalizations.of(context).translate("outOfStock"),
                  textScaleFactor: 1.1,
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: FittedBox(
                      child: Text(
                    '6',
                    // state.productList.length.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red[900]),
                  )),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Total Room',
                  // AppLocalizations.of(context).translate("outOfStock"),
                  textScaleFactor: 1.1,
                ),
              ],
            )
          ],
        )),
  );
  // return Builder(builder: (context) {
  //   return GestureDetector(
  //     onTap: () {
  //       // Navigator.pushNamed(context, outOfStock);
  //     },
  //     child: Container(
  //         padding: EdgeInsets.all(15),
  //         width: double.infinity,
  //         // height: double.infinity,
  //         decoration: new BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             gradient: new LinearGradient(
  //               colors: [
  //                 Colors.pink[50],
  //                 Colors.pink[100],
  //                 Colors.pink[200],
  //                 Colors.red[200]
  //               ],
  //             )),
  //         child: BlocBuilder<OutOfStockBloc, OutOfStockState>(
  //             builder: (context, state) {
  //           if (state is FetchedOutOfStock) {
  //             return Column(
  //               children: [
  //                 Expanded(
  //                   child: FittedBox(
  //                       child: Text(
  //                     state.productList.length.toString(),
  //                     style: TextStyle(
  //                         fontWeight: FontWeight.bold, color: Colors.red[900]),
  //                   )),
  //                 ),
  //                 SizedBox(
  //                   height: 5,
  //                 ),
  //                 Text(
  //                   AppLocalizations.of(context).translate("outOfStock"),
  //                   textScaleFactor: 1.1,
  //                 ),
  //               ],
  //             );
  //           } else if (state is ErrorFetchedOutOfStock) {
  //             return TextButton(onPressed: () {}, child: Text("Retry"));
  //           } else {
  //             return Center(
  //               child: CircularProgressIndicator(),
  //             );
  //           }
  //         })),
  //   );
  // });
}
