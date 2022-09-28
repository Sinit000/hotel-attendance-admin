import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

Widget recentSaleTile() {
  return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      // height: double.infinity,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: new LinearGradient(
            colors: [
              // HexColor('#afaaff'),
              // Colors.purple[300],
              HexColor('#6DD5FA'),
              HexColor('#6DD5FA'),
              // HexColor('#afaaff'),
              // HexColor('#afaaff'),
              // HexColor('#f7ccff'),
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
                  '2',
                  // state.productList.length.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red[900]),
                )),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Booking',
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
                  '1',
                  // state.productList.length.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red[900]),
                )),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Checkin',
                // AppLocalizations.of(context).translate("outOfStock"),
                textScaleFactor: 1.1,
              ),
            ],
          )
        ],
      ));
  return Container(
      padding: EdgeInsets.all(0),
      width: double.infinity,
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: new LinearGradient(
            colors: [
              //   Colors.blue[50],
              // HexColor('#FFFFFF'),
              // HexColor('#2980B9'),
              HexColor('#6DD5FA'),
              HexColor('#6DD5FA'),
              // HexColor('#FFFFFF'),
              // Colors.blue[100],
              // Colors.blue[200],
              // Colors.blue[200]
            ],
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, saleReport);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Active ',
                    // AppLocalizations.of(context).translate("lastSale"),
                    textScaleFactor: 1.1,
                  ),
                  Text(
                    'all',
                    // "  ${AppLocalizations.of(context).translate("all")}  ",
                    textScaleFactor: 1.1,
                  ),
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15), child: Divider()),
          Column(
            children: [saleReportTile(), SizedBox(height: 15)],
          )
          // BlocBuilder(
          //     cubit: BlocProvider.of<SaleBloc>(context),
          //     builder: (BuildContext context, SaleState state) {
          //       if (BlocProvider.of<SaleBloc>(context).saleReport.length ==
          //           0) {
          //         return Container(
          //           width: 0,
          //           height: 0,
          //         );
          //       }
          //       return Column(
          //         children: [
          //           BlocProvider.of<SaleBloc>(context).saleReport.length > 0
          //               ? saleReportTile(
          //                   sale: BlocProvider.of<SaleBloc>(context)
          //                       .saleReport[0])
          //               : Container(),
          //           // ...BlocProvider.of<SaleBloc>(context)
          //           //     .saleReport
          //           //     .map((sale) => saleReportTile(sale: sale))
          //           //     .toList()
          //           SizedBox(height: 15)
          //         ],
          //       );
          //     })
        ],
      ));
  // return Builder(
  //   builder: (context) {
  //     BlocProvider.of<SaleBloc>(context).add(FetchSaleReport());

  //     return Container(
  //         padding: EdgeInsets.all(0),
  //         width: double.infinity,
  //         decoration: new BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             gradient: new LinearGradient(
  //               colors: [
  //                 //   Colors.blue[50],
  //                 Colors.blue[100],
  //                 Colors.blue[200],
  //                 Colors.blue[200]
  //               ],
  //             )),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             SizedBox(height: 15),
  //             GestureDetector(
  //               onTap: () {
  //                 Navigator.pushNamed(context, saleReport);
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 15),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       AppLocalizations.of(context).translate("lastSale"),
  //                       textScaleFactor: 1.1,
  //                     ),
  //                     Text(
  //                       "  ${AppLocalizations.of(context).translate("all")}  ",
  //                       textScaleFactor: 1.1,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 15),
  //                 child: Divider()),
  //             BlocBuilder(
  //                 cubit: BlocProvider.of<SaleBloc>(context),
  //                 builder: (BuildContext context, SaleState state) {
  //                   if (BlocProvider.of<SaleBloc>(context).saleReport.length ==
  //                       0) {
  //                     return Container(
  //                       width: 0,
  //                       height: 0,
  //                     );
  //                   }
  //                   return Column(
  //                     children: [
  //                       BlocProvider.of<SaleBloc>(context).saleReport.length > 0
  //                           ? saleReportTile(
  //                               sale: BlocProvider.of<SaleBloc>(context)
  //                                   .saleReport[0])
  //                           : Container(),
  //                       // ...BlocProvider.of<SaleBloc>(context)
  //                       //     .saleReport
  //                       //     .map((sale) => saleReportTile(sale: sale))
  //                       //     .toList()
  //                       SizedBox(height: 15)
  //                     ],
  //                   );
  //                 })
  //           ],
  //         ));
  //   },
  // );
}

Widget saleReportTile(
    // {@required Sale sale}
    ) {
  return Builder(
    builder: (context) {
      return GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, saleDetail, arguments: sale.id);
        },
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Container(
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('invoiceNo:'),
                    Text('#112'),
                    // Text(
                    //     "${AppLocalizations.of(context).translate("invoiceNo")}: "),
                    // Text(sale.refNo)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('Date: 2021-07-16')
                    // Text("${AppLocalizations.of(context).translate("date")}: "),
                    // Text(sale.date.split(" ").first.split("-").last +
                    //     "-" +
                    //     sale.date.split(" ").first.split("-")[1] +
                    //     "-" +
                    //     sale.date.split(" ").first.split("-").first +
                    //     " " +
                    //     sale.date.split(" ").last)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('Total :'),
                    Text('\$30')
                    // Text(
                    //     "${AppLocalizations.of(context).translate("total")}: "),
                    // Text("\$${sale.total.toStringAsFixed(2)}",
                    //     style: TextStyle(color: Colors.black))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('Discount :'),
                    Text('\$10', style: TextStyle(color: Colors.yellow[800])),

                    // Text(
                    //     "${AppLocalizations.of(context).translate("discount")}: "),
                    // Text("\$${sale.discount.toStringAsFixed(2)}",
                    //     style: TextStyle(color: Colors.yellow[800]))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('Grand total :'),
                    Text('\$20', style: TextStyle(color: Colors.red))
                    // Text(
                    //     "${AppLocalizations.of(context).translate("grandTotal")}: "),
                    // Text("\$${sale.grandTotal.toStringAsFixed(2)}",
                    //     style: TextStyle(color: Colors.red))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
