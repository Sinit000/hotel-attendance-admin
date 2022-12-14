import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/appLocalizations.dart';

import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';

import 'package:hotle_attendnce_admin/src/feature/language/sreen/language.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/screen/leavetype.dart';
import 'package:hotle_attendnce_admin/src/feature/setting/screen/widget/dialogExport.dart';
import 'package:hotle_attendnce_admin/src/feature/setting/screen/widget/setting_item.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class OperationPage extends StatefulWidget {
  const OperationPage({Key? key}) : super(key: key);

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  double rowSpaceSize = 5;

  @override
  Widget build(BuildContext context) {
    final List<Map> homeMenu = [
      // {
      //   "name": "${AppLocalizations.of(context)!.translate("qr")!}",
      //   "iconColor": Colors.redAccent[200],
      //   "image": "assets/icon/qr-logo.png",
      //   "onPressed": () {
      //     Navigator.pushNamed(context, qr);
      //   }
      // },
      {
        "name": "${AppLocalizations.of(context)!.translate("location")!}",
        "iconColor": Colors.purple[300],
        "image": "assets/icon/maps-and-flags.png",
        "onPressed": () {
          Navigator.pushNamed(context, location);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("department")!}",
        "iconColor": Colors.lightGreen,
        "image": "assets/icon/diagram.png",
        "onPressed": () {
          Navigator.pushNamed(context, department);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("position")!}",
        "iconColor": Colors.orange,
        "image": "assets/icon/businesswoman.png",
        "onPressed": () {
          Navigator.pushNamed(context, position);
        }
      },
      // {
      //   "name": "${AppLocalizations.of(context)!.translate("schdeule")!}",
      //   "iconColor": Colors.lightBlue[300],
      //   "image": "assets/icon/timetable.png",
      //   "onPressed": () {
      //     Navigator.pushNamed(context, timetable);
      //   }
      // },
      {
        "name": "${AppLocalizations.of(context)!.translate("workday")!}",
        "iconColor": Colors.green,
        "image": "assets/icon/calendar.png",
        "onPressed": () {
          Navigator.pushNamed(context, workDay);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("timetable")!}",
        "iconColor": Colors.purple[300],
        "image": "assets/icon/calendar.png",
        "onPressed": () {
          Navigator.pushNamed(context, timetable);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("holiday")!}",
        "iconColor": Colors.lightBlue[300],
        "image": "assets/icon/calendar (1).png",
        "onPressed": () {
          Navigator.pushNamed(context, holiday);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("leave_type")!}",
        "iconColor": Colors.lightBlue[300],
        "image": "assets/icon/types.png",
        "onPressed": () {
          Navigator.pushNamed(context, leavetype);
          // Navigator.push(
          // context, MaterialPageRoute(builder: (context) => Leavetype()));
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("reset_password")!}",
        "iconColor": Colors.lightGreen,
        "image": "assets/icon/change_password.png",
        "onPressed": () {
          Navigator.pushNamed(context, resetpassword);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("chooseLang")!}",
        "iconColor": Colors.redAccent[200],
        "image": "assets/icon/language.png",
        "onPressed": () {
          // Navigator.pushNamed(context, setting);
          languageModal(context);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("counter")!}",
        "iconColor": Colors.lightBlue[300],
        "image": "assets/icon/tachometer.png",
        "onPressed": () {
          // dialogExport(context);
          Navigator.pushNamed(context, counter);
        }
      },
      {
        "name":
            "${AppLocalizations.of(context)!.translate("checkin_history")!}",
        "iconColor": Colors.orange,
        "image": "assets/icon/history.png",
        "onPressed": () {
          // dialogExport(context);
          Navigator.pushNamed(context, history);
        }
      },
    ];

    // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
        context,
        "${AppLocalizations.of(context)!.translate("operation")!}",
      ),
      body: ListView(
        clipBehavior: Clip.none,
        children: [
          OrientationBuilder(builder: (context, orie) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              // child: GridView.count(crossAxisCount: 2,children: [

              // ],),
              child: GridView.builder(
                padding: EdgeInsets.only(
                  top: 0,
                  left: 10,
                  right: 10,
                  bottom: 15,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 4 / 2.5,
                    crossAxisCount: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? 2
                        : 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15),
                itemBuilder: (_, index) =>
                    // menuItemTile(
                    //     alignment: Alignment.center,
                    //     iconBackgroundColor: Colors.green,
                    //     iconPath: homeMenu[index]["image"],
                    //     title: "Attendance",
                    //     // overidingColor: _isEnabled ? null : lockedColor,
                    //     onPressed: () {
                    //       // if (_isEnabled) {
                    //       //   Navigator.pushNamed(context, posAndSaleApp);
                    //       // }
                    //     }),
                    settingMenuTile(
                        iconColor: homeMenu[index]["iconColor"],
                        name: homeMenu[index]["name"],
                        image: homeMenu[index]["image"],
                        onPressed: homeMenu[index]["onPressed"]),
                itemCount: homeMenu.length,
              ),
            );
          }),
          SizedBox(
            height: 20,
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     // Container(
          //     //   child: Text("Anakut Digital Solution"),
          //     // ),
          //     Container(
          //       child: Text("Version 1.0.1"),
          //     )
          //   ],
          // ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
