import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/model/payslip_model.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/screen/add_payslip.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';

import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class PayslipListMonthly extends StatelessWidget {
  final String month;
  final String year;
  final String dateRange;
  const PayslipListMonthly(
      {required this.month, required this.year, required this.dateRange});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("payslip")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Body(
            monthly: dateRange,
          )),
      // floatingActionButton: Container(
      //   child: FloatingActionButton(
      //       backgroundColor: Colors.blue,
      //       child: Icon(Icons.add),
      //       elevation: 0,
      //       onPressed: () {
      //         // Navigator.pushNamed(context, addP);
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => AddPayslip(monthly: month)));
      //       }),
      // ),
    );
  }
}

class Body extends StatefulWidget {
  final String monthly;
  const Body({required this.monthly});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String mydateRage = "";
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    mydateRage = widget.monthly;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PayslipBloc>(context)
        .add(InitailizePayslipStarted(dateRange: mydateRage));
    return BlocConsumer(
        bloc: BlocProvider.of<PayslipBloc>(context),
        builder: (context, state) {
          print(state);

          if (state is InitailizingPayslip) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }
          if (state is ErrorFetchingPayslip) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            if (BlocProvider.of<PayslipBloc>(context).payslip.length == 0) {
              return Center(
                child: Text("No data"),
              );
            }
            // print(_reportBloc.dateRange!);
            return Column(
              children: [
                Expanded(
                    child: SmartRefresher(
                  onRefresh: () {
                    print("fetch dateRange");
                    print(mydateRage);
                    BlocProvider.of<PayslipBloc>(context)
                        .add(RefreshPayslipStarted(dateRange: mydateRage));
                  },
                  onLoading: () {
                    print("fetch dateRange");
                    print(mydateRage);
                    BlocProvider.of<PayslipBloc>(context)
                        .add(FetchPayslipStarted(dateRange: mydateRage));
                  },
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  child: SingleChildScrollView(
                    child: Column(
                      // addAutomaticKeepAlives: true,
                      children: [
                        ListView.builder(
                          cacheExtent: 1000,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

                          itemCount: BlocProvider.of<PayslipBloc>(context)
                              .payslip
                              .length,
                          itemBuilder: (context, index) {
                            return _buildContainer(
                                context,
                                BlocProvider.of<PayslipBloc>(context)
                                    .payslip[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ))
                // user condition to avoid null and cause error while data is fetching
                // BlocProvider.of<PayslipBloc>(context).dateRange == null
                //     ? Container()
                //     : Container(
                //         padding: EdgeInsets.only(left: 20),
                //         alignment: Alignment.centerLeft,
                //         child: DropdownButton<String>(
                //           hint: BlocProvider.of<PayslipBloc>(context)
                //                   .dateRange!
                //                   .contains("to")
                //               ? Text(
                //                   "${BlocProvider.of<PayslipBloc>(context).dateRange!}")
                //               : Text(
                //                   // leaveBloc.dateRange!,
                //                   // _reportBloc.dateRange!.contains("to")
                //                   //     ? _reportBloc.dateRange!
                //                   //     :W
                //                   "${BlocProvider.of<PayslipBloc>(context).dateRange!}",
                //                   textScaleFactor: 1,
                //                 ),
                //           items: [
                //             // 'Last year',
                //             'This year',
                //             // 'Next year',
                //             "Custom"
                //           ].map((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //           onChanged: (value) {
                //             if (value == "Custom") {
                //               showPickerDateRange(context);
                //             } else {
                //               setState(() {
                //                 mydateRage = value!;
                //                 print("myvalue $mydateRage");
                //                 print(mydateRage);
                //               });
                //               BlocProvider.of<PayslipBloc>(context).add(
                //                   InitailizePayslipStarted(dateRange: value));
                //             }
                //           },
                //         ),
                //       ),
                // Container(
                //   width: double.infinity,
                //   height: 10,
                //   color: Colors.transparent,
                // ),
                // BlocProvider.of<PayslipBloc>(context).payslip.length == 0
                //     ? Container(
                //         child: Text("No data"),
                //       )
                //     : Expanded(
                //         child: SmartRefresher(
                //         onRefresh: () {
                //           print("fetch dateRange");
                //           print(mydateRage);
                //           BlocProvider.of<PayslipBloc>(context).add(
                //               RefreshPayslipStarted(dateRange: mydateRage));
                //         },
                //         onLoading: () {
                //           print("fetch dateRange");
                //           print(mydateRage);
                //           BlocProvider.of<PayslipBloc>(context)
                //               .add(FetchPayslipStarted(dateRange: mydateRage));
                //         },
                //         enablePullDown: true,
                //         enablePullUp: true,
                //         controller: _refreshController,
                //         child: SingleChildScrollView(
                //           child: Column(
                //             // addAutomaticKeepAlives: true,
                //             children: [
                //               ListView.builder(
                //                 cacheExtent: 1000,
                //                 physics: NeverScrollableScrollPhysics(),
                //                 shrinkWrap: true,
                //                 // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

                //                 itemCount: BlocProvider.of<PayslipBloc>(context)
                //                     .payslip
                //                     .length,
                //                 itemBuilder: (context, index) {
                //                   return _buildContainer(
                //                       context,
                //                       BlocProvider.of<PayslipBloc>(context)
                //                           .payslip[index]);
                //                 },
                //               ),
                //             ],
                //           ),
                //         ),
                //       )),
              ],
            );
          }
          // return Center();
        },
        listener: (context, state) {
          print("state");
          print(state);
          if (state is FetchedPayslip) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndofPayslip) {
            _refreshController.loadNoData();
          }
        });
  }

  // return BlocConsumer(
  //   bloc: BlocProvider.of<PayslipBloc>(context),
  //   listener: (context, state) {
  //     if (state is ErrorFetchingPayslip) {}
  //     // if (state is ErrorFetchingEmployee) {
  //     //   Helper.handleState(state: state, context: context);
  //     // }
  //     if (state is FetchedPayslip) {
  //       _refreshController.loadComplete();
  //       _refreshController.refreshCompleted();
  //     }
  //     if (state is EndofPayslip) {
  //       _refreshController.loadNoData();
  //     }
  //     if (state is AddingPayslip) {
  //       EasyLoading.show(status: "loading....");
  //     } else if (state is ErrorAddingPayslip) {
  //       EasyLoading.dismiss();
  //       errorSnackBar(text: state.error.toString(), context: context);
  //     } else if (state is AddedPayslip) {
  //       EasyLoading.dismiss();
  //       EasyLoading.showSuccess("Sucess");
  //     }
  //   },
  //   builder: (context, state) {
  //     if (state is InitailizingPayslip) {
  //       return Center(
  //         child: Lottie.asset('assets/animation/loader.json',
  //             width: 200, height: 200),
  //       );
  //     } else if (state is ErrorFetchingPayslip) {
  //       return Center(
  //         child: Text(state.error.toString()),
  //       );
  //     } else {
  //       if (BlocProvider.of<PayslipBloc>(context).payslip.length == 0) {
  //         return Center(
  //           child: Text(
  //               "${AppLocalizations.of(context)!.translate("no_data")!}"),
  //         );
  //       }
  //       return SmartRefresher(
  //         controller: _refreshController,
  //         onLoading: () {
  //           BlocProvider.of<PayslipBloc>(context)
  //               .add(FetchPayslipStarted(dateRange: ""));
  //           _refreshController.loadNoData();
  //         },
  //         onRefresh: () {
  //           BlocProvider.of<PayslipBloc>(context)
  //               .add(InitailizePayslipStarted(dateRange: ""));
  //         },
  //         enablePullDown: true,
  //         enablePullUp: true,
  //         cacheExtent: 1,
  //         child: ListView.builder(
  //             itemCount: BlocProvider.of<PayslipBloc>(context).payslip.length,
  //             itemBuilder: (context, index) {
  //               return _buildContainer(context,
  //                   BlocProvider.of<PayslipBloc>(context).payslip[index]);
  //             }),
  //       );
  //     }
  //   },
  // );

  _buildContainer(BuildContext context, PayslipModel payslipModel) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 10),
      child: TextButton(
          style: TextButton.styleFrom(
            // backgroundColor: Colors.blue,
            padding: EdgeInsets.all(20),
          ),
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => EmployeeDetailPage(
            //             employeeModel:
            //                 employeeBloc.emploList[index])));
          },
          child: Row(
            children: [
              // employeeBloc.emploList[index].img == null
              //     ?
              // Container(
              //     height: 80,
              //     width: 80,
              //     child:
              //         Image.asset("assets/icon/avartar.png"),
              //   ),
              // :
              Container(
                  height: 80,
                  width: 80,
                  // padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[300]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset("assets/icon/avartar.png"),
                    // child: FadeInImage.assetNetwork(
                    //   placeholder: "assets/icon/avartar.png",
                    //   // imageCacheHeight: 80,
                    //   // imageCacheWidth: 80,
                    //   image:
                    //       "https://banban-hr.herokuapp.com/${employeeBloc.emploList[index].img}",
                    //   fit: BoxFit.fill,
                    // ),
                  )),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          payslipModel.userModel!.name,
                          textAlign: TextAlign.right,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        // AspectRatio(aspectRatio: 1)
                      ],
                    ),
                    SizedBox(height: 10),
                    payslipModel.currey == "riel"
                        ? Text(
                            "\riel${payslipModel.netSalary!}",
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.right,
                          )
                        : Text(
                            "\$${payslipModel.netSalary!}",
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.right,
                          ),
                    // SizedBox(height: 10),
                    // employeeBloc.emploList[index].address == null
                    //     ? Text("")
                    //     : Text(
                    //         employeeBloc
                    //             .emploList[index].address!,
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .subtitle2,
                    //         textAlign: TextAlign.right,
                    //       ),
                  ],
                ),
              ),
              // CupertinoButton(
              //     padding: EdgeInsets.all(1.0),
              //     color: Colors.blue,
              //     child: Row(
              //       children: [
              //         Icon(Icons.edit),
              //       ],
              //     ),
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (con) => EditEmployee(
              //       //               employeeModel: employeeBloc
              //       //                   .emploList[index],
              //       //             )));
              //     }),
              // SizedBox(
              //   width: 3,
              // ),
              // CupertinoButton(
              //     padding: EdgeInsets.all(1.0),
              //     color: Colors.red,
              //     child: Row(
              //       children: [
              //         Icon(Icons.delete),
              //       ],
              //     ),
              //     onPressed: () {
              //       deleteDialog(
              //           context: context,
              //           onPress: () {
              //             Navigator.pop(context);
              //           });
              //     }),
            ],
          )),
    );
  }

  showPickerDateRange(BuildContext context) {
    String? _startDate;
    String? _endDate;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    Picker ps = Picker(
        confirmText: "Confirm",
        cancelText: "Cancel",
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: false),
        onConfirm: (Picker picker, List value) {
          _startDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          _endDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(PickerLocalizations.of(context).cancelText!)),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm!(ps, ps.selecteds);
            pe.onConfirm!(pe, pe.selecteds);
            BlocProvider.of<PayslipBloc>(context).add(
                InitailizePayslipStarted(dateRange: "$_startDate/$_endDate"));
          },
          child: Text(PickerLocalizations.of(context).confirmText!))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Date"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Start :"),
                  ps.makePicker(),
                  Text("End :"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }
}
