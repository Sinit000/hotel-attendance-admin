import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/home/screen/widget/home_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../appLocalizations.dart';
import 'my_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Map> homeMenu = [
      {
        "name": "${AppLocalizations.of(context)!.translate("dashboard")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/dashboard.png",
        "onPressed": () {
          Navigator.pushNamed(context, dashboard);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("attendance")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/checking-attendance.png",
        "onPressed": () {
          Navigator.pushNamed(context, attendance);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("employee")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/group.png",
        "onPressed": () {
          Navigator.pushNamed(context, employee);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("approve_board")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/clock1.png",
        "onPressed": () {
          Navigator.pushNamed(context, approveBaord);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("ot")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/overtime.png",
        "onPressed": () {
          Navigator.pushNamed(context, overtime);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("payslip")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/money.png",
        "onPressed": () {
          Navigator.pushNamed(context, configuration);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("report")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/analytics.png",
        "onPressed": () {
          Navigator.pushNamed(context, report);
        }
      },
      {
        "name": "${AppLocalizations.of(context)!.translate("operation")!}",
        "iconColor": Colors.blue,
        "image": "assets/blackIcon/customer-support.png",
        "onPressed": () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingPage()));
          Navigator.pushNamed(context, operation);
        }
      },
    ];

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100),
          child: MyAppBar(
            username:
                "${BlocProvider.of<AuthenticationBloc>(context).state.user!.name}",
          )),
      body: ListView(
        clipBehavior: Clip.none,
        children: [
          Stack(
            children: [
              Container(
                height:
                    15 + ((MediaQuery.of(context).size.width / 2) - (45)) / 2.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: new Radius.elliptical(
                          MediaQuery.of(context).size.width, 60.0)),
                  color: Theme.of(context).primaryColor,
                ),
              ),
              OrientationBuilder(builder: (context, orie) {
                return Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // child: GridView.count(crossAxisCount: 2,children: [

                  // ],),
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                        top: 0, right: 15, bottom: 15, left: 15),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4 / 2.5,
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 3,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15),
                    itemBuilder: (_, index) => homeItem(
                        iconColor: homeMenu[index]["iconColor"],
                        name: homeMenu[index]["name"],
                        image: homeMenu[index]["image"],
                        onPressed: homeMenu[index]["onPressed"]),
                    itemCount: homeMenu.length,
                  ),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
