import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/screen/announcement_page.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/screen/notification_page.dart';
import 'package:flutter/material.dart';

import '../../../appLocalizations.dart';

class MyAppBar extends StatefulWidget {
  final String username;
  const MyAppBar({required this.username});

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AnnouncementBloc>(context)
    //     .add(SetReadingStatus(isRead: isRead));
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          // borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(20),
          //     bottomRight: Radius.circular(20))
        ),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("wel_home")!} ${widget.username}",
                    textScaleFactor: 1.7,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                  // Image.asset('assets/icon/logo1.png')
                  ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                  "${AppLocalizations.of(context)!.translate("alert")!}"),
                              content: Text(
                                  "${AppLocalizations.of(context)!.translate("alert_text")!}"),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "${AppLocalizations.of(context)!.translate("no")!}",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(LogoutPressed());
                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                  },
                                  child: Text(
                                      "${AppLocalizations.of(context)!.translate("yes")!}",
                                      style: TextStyle(color: Colors.blue)),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      alignment: Alignment.center,
                      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // shape: BoxShape.circle,
                        color: Colors.blue[300],
                      ),
                      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                      child: Center(
                        child: Icon(
                          Icons.exit_to_app_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, notification);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnnouncementPage()));
                    },
                    child: Container(
                      width: 45,
                      height: 45,
                      alignment: Alignment.center,
                      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        // shape: BoxShape.circle,
                        color: Colors.blue[300],
                      ),
                      margin: EdgeInsets.only(top: 4, right: 10),
                      child: Center(
                        child: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // Container(
              //   padding: EdgeInsets.only(right: 20),
              //   child: IconButton(
              //     icon: Icon(
              //       Icons.notifications_none_outlined,
              //       color: Colors.white,
              //       size: 38,
              //     ),
              //     onPressed: () {

              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
