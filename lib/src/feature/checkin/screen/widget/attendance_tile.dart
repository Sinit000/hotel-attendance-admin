import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
// import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:intl/intl.dart';

import 'action_btn.dart';

class AttendanceTile extends StatefulWidget {
  final EmployeeModel employeeModel;

  const AttendanceTile({required this.employeeModel});

  @override
  State<AttendanceTile> createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? checkin;
  String? data;
  String? checkinTime;
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    checkin = formattedDate.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 6,
      child: Card(
        // color: Colors.greenAccent.withOpacity(0.5),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: 100,
                height: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    // child: Image.asset(
                    //     "assets/icon/avartar.png"),
                    child: widget.employeeModel.img == null
                        ? Image.asset("assets/icon/avartar.png")
                        : FadeInImage.assetNetwork(
                            placeholder: "assets/icon/avartar.png",
                            // imageCacheHeight: 80,
                            // imageCacheWidth: 80,
                            image:
                                "https://banban-hr.herokuapp.com/${widget.employeeModel.img}",
                            fit: BoxFit.fill,
                          )
                    // CachedNetworkImage(
                    //     imageUrl:
                    //         "https://banban-hr.herokuapp.com/${widget.employeeModel.img}",
                    //   ),
                    ),
              ),

              // Container(
              //   padding: EdgeInsets.only(top: 5),
              //   child: Text("Admin Rock"),
              // ),
              Container(
                padding:
                    EdgeInsets.only(top: 5, left: 10, right: 5, bottom: 10),
                child: Center(
                  child: Text("${widget.employeeModel.name}"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.employeeModel.checkinStatus == "leave"
                        ? actionButton(
                            title: "Leave",
                            color: Colors.red,
                          )
                        : widget.employeeModel.checkinStatus == "present"
                            ? actionButton(
                                title: "Present",
                                color: Colors.lightBlue,
                              )
                            : widget.employeeModel.checkinStatus == "false"
                                ? actionButton(
                                    title: "Checkin",
                                    color: Colors.green,
                                    onPressed: () {
                                      checkinTime = checkin!.substring(11, 19);
                                      print(checkinTime);
                                      BlocProvider.of<CheckInOutBloc>(context)
                                          .add(AddCheckinStarted(
                                              checkinTime: checkinTime!,
                                              employeeId:
                                                  widget.employeeModel.id));
                                    })
                                : widget.employeeModel.checkinStatus == "absent"
                                    ? actionButton(
                                        title: "Absent",
                                        color: Colors.red,
                                      )
                                    : actionButton(
                                        title: "Checkout",
                                        color: Colors.amberAccent[700]!,
                                        onPressed: () {
                                          checkinTime =
                                              checkin!.substring(11, 19);
                                          print(checkinTime);
                                          BlocProvider.of<
                                                  CheckInOutBloc>(context)
                                              .add(AddCheckoutStarted(
                                                  id: widget
                                                      .employeeModel.checkinId!,
                                                  checkoutTime: checkinTime!,
                                                  employeeId:
                                                      widget.employeeModel.id));
                                        }),
                    SizedBox(
                      width: 5,
                    ),
                    widget.employeeModel.checkinStatus == "leave"
                        ? Container()
                        : widget.employeeModel.checkinStatus == "true"
                            ? Container()
                            : widget.employeeModel.checkinStatus == "present"
                                ? Container()
                                : widget.employeeModel.checkinStatus == "absent"
                                    ? Container()
                                    : InkWell(
                                        onTap: () {
                                          BlocProvider.of<CheckInOutBloc>(
                                                  context)
                                              .add(MarkAbsentStarted(
                                                  userId:
                                                      widget.employeeModel.id));
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          alignment: Alignment.center,
                                          // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            // shape: BoxShape.circle,
                                            color: Colors.blue[300],
                                          ),
                                          // margin: EdgeInsets.only(top: 4, right: 10),
                                          child: Center(
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   child: Text(widget.employeeModel.name),
    // );
  }
}
