import 'package:hotle_attendnce_admin/src/utils/share/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../../../appLocalizations.dart';

Widget appBar({required BuildContext context}) {
  double statusBarHeight = MediaQuery.of(context).padding.top;
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  return Container(
    // color: Theme.of(context).primaryColor,
    margin: EdgeInsets.all(0),
    width: MediaQuery.of(context).size.width - 30,
    height: double.infinity,
    color: Colors.green[700],
    // color: (state == 0)
    //     ? Colors.red
    //     // Theme.of(context).primaryColor
    //     : Theme.of(context).scaffoldBackgroundColor,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: EdgeInsets.only(top: statusBarHeight, right: 0),
            child: AspectRatio(
              aspectRatio: 1,
              child: FittedBox(
                fit: BoxFit.fitHeight,
                child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon:
                        Icon(Icons.notifications_outlined, color: Colors.white),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => NotificationPage()));
                    }),
              ),
            )),
        // Container(
        //   margin: EdgeInsets.only(top: statusBarHeight, right: 0, left: 0),
        //   child: AspectRatio(
        //     aspectRatio: 1,
        //     child: FlatButton(
        //       color: Colors.transparent,
        //       padding: EdgeInsets.only(top: 13, bottom: 13, right: 0, left: 0),
        //       child: Image(
        //         image: AssetImage(
        //             BlocProvider.of<LanguageBloc>(context).state ==
        //                     LanguageState(Locale('en', 'US'))
        //                 ? "assets/icon/en_us.png"
        //                 : "assets/icon/km_kh.png"),
        //       ),
        //       onPressed: () {
        //         languageModal(context);
        //       },
        //     ),
        //   ),
        // ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              // showSearch(context: context, delegate: SearchPage());
            },
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius:
                      BorderRadius.all(Radius.circular(searchBarBorderRadius))),
              margin: EdgeInsets.only(
                  left: 0, top: statusBarHeight + 10, right: 15, bottom: 10),
              child: Card(
                margin: EdgeInsets.only(left: 0),
                color: Colors.grey[200],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(searchBarBorderRadius),
                ),
                //margin: EdgeInsets.all(0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey[700],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Search",
                      // AppLocalizations.of(context)!.translate("search")!,
                      style: TextStyle(color: Colors.grey[700]),
                      textScaleFactor: 1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // Container(
        //     margin: EdgeInsets.only(top: statusBarHeight, right: 0),
        //     child: AspectRatio(
        //       aspectRatio: 1,
        //       child: FittedBox(
        //         fit: BoxFit.fitHeight,
        //         child: IconButton(
        //             padding: EdgeInsets.all(0),
        //             icon: Icon(Icons.chat_bubble_rounded, color: Colors.white),
        //             onPressed: () {
        //               Navigator.push(context,
        //                   MaterialPageRoute(builder: (context) => ChartPage()));
        //             }),
        //       ),
        //     ))
      ],
    ),
  );
 
}
