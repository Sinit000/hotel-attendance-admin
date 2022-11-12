import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/widget/workday.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/menu_item.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

import '../../../appLocalizations.dart';

class Employeedetail extends StatefulWidget {
  final EmployeeModel employeeModel;
  const Employeedetail({required this.employeeModel});

  @override
  State<Employeedetail> createState() => _EmployeedetailState();
}

class _EmployeedetailState extends State<Employeedetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: standardAppBar(context,
            "${AppLocalizations.of(context)!.translate("employee_detail")!}"),
        body: Stack(
          children: [
            Container(
              height: 70,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // custom detail tile
                    menuItemTile(
                      onPressed: () {},
                      overidingWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "${AppLocalizations.of(context)!.translate("name")!} : ",
                                  style: Theme.of(context).textTheme.bodyText1),
                              Expanded(
                                child: Text(
                                  widget.employeeModel.name,
                                  textScaleFactor: 1.1,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                  "${AppLocalizations.of(context)!.translate("cardNumber")!} : ",
                                  style: Theme.of(context).textTheme.bodyText1),
                              widget.employeeModel.card == null
                                  ? Text("")
                                  : Expanded(
                                      child: Text(
                                        widget.employeeModel.card!,
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                  "${AppLocalizations.of(context)!.translate("dob")!} : ",
                                  style: Theme.of(context).textTheme.bodyText1),
                              widget.employeeModel.dob == null
                                  ? Text("")
                                  : Expanded(
                                      child: Text(
                                        widget.employeeModel.dob!,
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                  "${AppLocalizations.of(context)!.translate("nationality")!} : ",
                                  style: Theme.of(context).textTheme.bodyText1),
                              widget.employeeModel.nationalilty == null
                                  ? Text("")
                                  : Expanded(
                                      child: Text(
                                        widget.employeeModel.nationalilty!,
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 5),
                          // Row(
                          //   children: [
                          //     Text("Address : ",
                          //         style: Theme.of(context).textTheme.bodyText1),
                          //     widget.accountModel.address == null
                          //         ? Text("")
                          //         : Expanded(
                          //             child: Text(
                          //               widget.accountModel.address!,
                          //               textScaleFactor: 1.1,
                          //               style: TextStyle(
                          //                   color: Colors.black,
                          //                   fontWeight: FontWeight.bold),
                          //             ),
                          //           ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.translate("phone")!} : ",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              widget.employeeModel.phone == null
                                  ? Text("")
                                  : Expanded(
                                      child: Text(
                                        widget.employeeModel.phone!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 5),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.translate("email")!} : ",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              widget.employeeModel.email == null
                                  ? Text("")
                                  : Expanded(
                                      child: Text(
                                        "${widget.employeeModel.email}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 5),
                          widget.employeeModel.meritalStatus == null
                              ? Container()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.translate("merital_status")!} : ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    widget.employeeModel.meritalStatus == null
                                        ? Container()
                                        : Expanded(
                                            child: Text(
                                              "${widget.employeeModel.meritalStatus}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                  ],
                                ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.translate("sponse_job")!} : ",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              widget.employeeModel.coupleJob == null ||
                                      widget.employeeModel.coupleJob == "null"
                                  ? Container()
                                  : Expanded(
                                      child: Text(
                                        "${widget.employeeModel.coupleJob}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: 5),
                          widget.employeeModel.child == null
                              ? Container()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.translate("minor_children")!} : ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    widget.employeeModel.child == null ||
                                            widget.employeeModel.child == "null"
                                        ? Container()
                                        : Expanded(
                                            child: Text(
                                              "${widget.employeeModel.child}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                  ],
                                ),
                          // SizedBox(height: 5),
                          // widget.employeeModel.coupleJob == null
                          //     ? Container()
                          //     : Row(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             "${AppLocalizations.of(context)!.translate("sponse_job")!} : ",
                          //             style:
                          //                 Theme.of(context).textTheme.bodyText1,
                          //           ),
                          //           widget.employeeModel.coupleJob == null
                          //               ? Container()
                          //               : Expanded(
                          //                   child: Text(
                          //                     "${widget.employeeModel.coupleJob}",
                          //                     style: Theme.of(context)
                          //                         .textTheme
                          //                         .bodyText1,
                          //                   ),
                          //                 ),
                          //         ],
                          //       ),
                        ],
                      ),
                      iconBackgroundColor: Colors.white,
                      iconPath: '',
                      title: '',
                    ),
                    SizedBox(height: 10),
                    menuItemTile(
                      onPressed: () {},
                      overidingWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.translate("position")!} : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.orange[800]),
                                ),
                                Text(
                                  widget.employeeModel.positionModel!
                                      .positionName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(color: Colors.orange[800]),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.translate("department")!} : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(),
                                ),
                                Text(
                                  widget.employeeModel.departmentModel!.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                  "${AppLocalizations.of(context)!.translate("office_tel")!} : ",
                                  style: Theme.of(context).textTheme.bodyText1),
                              widget.employeeModel.officeTel == null
                                  ? Text("")
                                  : Expanded(
                                      child: Text(
                                        widget.employeeModel.officeTel!,
                                        textScaleFactor: 1.1,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ],
                          ),

                          //  accountBloc.accountModel!.type =="2" ? :  Row(
                          //       children: [
                          //         Text(
                          //           "Timetable : ",
                          //           style: Theme.of(context).textTheme.bodyText1,
                          //         ),

                          //         widget.accountModel.timetableModel== null
                          //             ? Text("")
                          //             : Expanded(
                          //                 child: Text(
                          //                   widget.accountModel.phone!,
                          //                   style:
                          //                       Theme.of(context).textTheme.bodyText1,
                          //                 ),
                          //               ),
                          //       ],
                          //     ),
                          SizedBox(height: 5),
                          widget.employeeModel.email == null
                              ? Container()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${AppLocalizations.of(context)!.translate("address")!} : ",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${widget.employeeModel.email}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                      iconBackgroundColor: Colors.white,
                      iconPath: '',
                      title: '',
                    ),

                    SizedBox(height: 10),

                    menuItemTile(
                      onPressed: () {},
                      overidingWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${AppLocalizations.of(context)!.translate("timetable")!}"),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.translate("time_in")!} : ",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Expanded(
                                child: Text(
                                  "${widget.employeeModel.timetableModel!.onDutyTtime}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.translate("time_out")!} : ",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Expanded(
                                child: Text(
                                  "${widget.employeeModel.timetableModel!.offDutyTime}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                          // Container(
                          //   height: 50,
                          //   child: time(context,
                          //       time: widget.accountModel.timetableModel!),
                          // ),
                          SizedBox(height: 5),
                        ],
                      ),
                      iconBackgroundColor: Colors.white,
                      iconPath: '',
                      title: '',
                    ),
                    SizedBox(height: 10),

                    menuItemTile(
                      onPressed: () {},
                      overidingWidget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${AppLocalizations.of(context)!.translate("workday")!}"),
                          Container(
                            height: MediaQuery.of(context).size.width / 3,
                            child: workday(context,
                                workday: widget.employeeModel.workingDayModel!
                                    .workingDay!),
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                      iconBackgroundColor: Colors.white,
                      iconPath: '',
                      title: '',
                    ),
                    SizedBox(height: 10),
                    // IntrinsicHeight(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //           child: menuItemTile(
                    //               onPressed: () {
                    //                 Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                         builder: (context) =>
                    //                             EditProfile(
                    //                               accountModel: accountBloc
                    //                                   .accountModel!,
                    //                             )));
                    //               },
                    //               title:
                    //                   "${AppLocalizations.of(context)!.translate("editProfile")!}",
                    //               iconPath: "assets/icon/edit.png",
                    //               iconBackgroundColor: Colors.blue)),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       // Expanded(
                    //       //     child: menuItemTile(
                    //       //         onPressed: () {
                    //       //           ;
                    //       //         },
                    //       //         title: AppLocalizations.of(context)!
                    //       //             .translate("saleHistory")!,
                    //       //         iconPath:
                    //       //             "assets/icons/customer_menu/history.png",
                    //       //         iconBackgroundColor: Colors.blue)),
                    //     ],
                    //   ),
                    // ),
                    // menuItemTile(
                    //   onPressed: () {},
                    //   overidingWidget: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Timetable"),
                    //       Container(
                    //         height: 50,
                    //         child: time(context,
                    //             time: widget.employeeModel.!),
                    //       ),
                    //       SizedBox(height: 5),
                    //     ],
                    //   ),
                    //   iconBackgroundColor: Colors.white,
                    //   iconPath: '',
                    //   title: '',
                    // ),
                    // SizedBox(height: 10),
                    // IntrinsicHeight(
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //           child: menuItemTile(
                    //               onPressed: () {
                    //                 Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                         builder: (context) => EditProfile(
                    //                               accountModel:
                    //                                   accountBloc.accountModel!,
                    //                             )));
                    //               },
                    //               title: "Edit Profile",
                    //               iconPath: "assets/icon/edit.png",
                    //               iconBackgroundColor: Colors.orange)),
                    //       SizedBox(
                    //         width: 10,
                    //       ),

                    //     ],
                    //   ),
                    // ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
