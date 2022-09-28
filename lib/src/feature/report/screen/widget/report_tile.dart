import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:hotle_attendnce_admin/src/feature/report/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:intl/intl.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:lottie/lottie.dart';

class ReportTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportBloc, ReportState>(
      listener: (context, state) {
        if (state is ErrorFetchedReport) {
          Helper.handleState(state: state, context: context);
        }
      },
      builder: (context, state) {
        if (state is ErrorFetchedReport) {
          // errorSnackBar(text: state.error, context: context);
          return TextButton(
            child: Text("Retry"),
            onPressed: () {},
          );
        }
        if (state is FetchedReport) {
          return Column(
            children: [
              Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green[200],
                ),
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                        hint: Text(
                          BlocProvider.of<ReportBloc>(context).dateRange!,
                          // AppLocalizations.of(context).translate(
                          //     BlocProvider.of<ReportBloc>(context).dateRange),
                          textScaleFactor: 0.9,
                          maxLines: 2,
                        ),
                        items: [
                          'Today',
                          'This week',
                          'This month',
                          'This year',
                          "Custom"
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                              )
                              // Text(AppLocalizations.of(context).translate(value)),
                              );
                        }).toList(),
                        onChanged: (value) {
                          if (value == "Custom") {
                            showPickerDateRange(context);
                          } else
                            BlocProvider.of<ReportBloc>(context)
                                .add(FetchReportStarted(dateRange: value!));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //  Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              state.report.late!,
                              textScaleFactor: 2.3,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Late",
                              textScaleFactor: 1.2,
                              // style: TextStyle(),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              state.report.overtime!,
                              textScaleFactor: 1.8,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Overtime",
                              textScaleFactor: 1.2,
                              // style: TextStyle(),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            FittedBox(
                                child: Text(
                              state.report.checkin!,
                              textScaleFactor: 1.8,
                              style: TextStyle(
                                  color: Colors.green[800],
                                  fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Check in",
                              textScaleFactor: 1.1,
                            )
                          ],
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            FittedBox(
                                child: Text(
                              // '10',
                              state.report.checkout!,
                              textScaleFactor: 1.8,
                              style: TextStyle(
                                  color: Colors.orange[800],
                                  fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Check out",
                              textScaleFactor: 1.1,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                width: double.infinity,
                // height: double.infinity,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: new LinearGradient(
                      colors: [
                        Colors.redAccent[200]!,
                        // Colors.purple[300],
                        Colors.redAccent[200]!,
                        Colors.redAccent[200]!,
                        Colors.redAccent[200]!,
                        // Colors.pink[50],
                        // Colors.pink[100],
                        // Colors.pink[200],
                        // Colors.red[200]
                      ],
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  Divider(),

                    Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              FittedBox(
                                  child: state.report.absent == null
                                      ? Text("")
                                      : Text(
                                          state.report.absent!,
                                          textScaleFactor: 3,
                                          style: TextStyle(
                                              color: Colors.green[800],
                                              fontWeight: FontWeight.bold),
                                        )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Absent",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900]),
                                textScaleFactor: 1.4,
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            children: [
                              FittedBox(
                                  child: Text(
                                // '10',
                                state.report.leave!,
                                textScaleFactor: 3,
                                style: TextStyle(
                                    color: Colors.orange[800],
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Leave",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900]),
                                textScaleFactor: 1.4,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(15),
                width: double.infinity,
                // height: double.infinity,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: new LinearGradient(
                      colors: [
                        HexColor('#6DD5FA'),
                        HexColor('#6DD5FA'),
                      ],
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  Divider(),

                    Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              FittedBox(
                                  child: Text(
                                state.report.employee,
                                textScaleFactor: 3,
                                style: TextStyle(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Total Employee",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900]),
                                textScaleFactor: 1.4,
                              ),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            children: [
                              FittedBox(
                                  child: Text(
                                // '10',
                                state.report.leave!,
                                textScaleFactor: 3,
                                style: TextStyle(
                                    color: Colors.orange[800],
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Leave",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900]),
                                textScaleFactor: 1.4,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(child: outOfStockTile())
            ],
          );
        }
        return Container(
          child: Center(
            // child: CircularProgressIndicator(),
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          ),
        );
      },
    );
    // return BlocBuilder<ReportBloc, ReportState>(
    //   builder: (context, state) {
    //     if (state is FetchedReport) {
    //       return Container(
    //         decoration: new BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           color: Colors.grey[200],
    //         ),
    //         padding: EdgeInsets.all(15),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: DropdownButton<String>(
    //                 hint: Text(
    //                   AppLocalizations.of(context).translate(
    //                       BlocProvider.of<ReportBloc>(context).dateRange),
    //                   textScaleFactor: 1.1,
    //                 ),
    //                 items: [
    //                   'Today',
    //                   'This week',
    //                   'This month',
    //                   'This year',
    //                   "Custom"
    //                 ].map((String value) {
    //                   return DropdownMenuItem<String>(
    //                     value: value,
    //                     child:Text(value)
    //                         // Text(AppLocalizations.of(context).translate(value)),
    //                   );
    //                 }).toList(),
    //                 onChanged: (value) {
    //                   if (value == "Custom") {
    //                     showPickerDateRange(context);
    //                 } else{}
    //                     // BlocProvider.of<ReportBloc>(context)
    //                     //     .add(FetchReportStarted(dateRange: value));
    //                 },
    //               ),
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             //  Divider(),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Column(
    //                   children: [
    //                     Text(
    //                       "\$" + state.report.income.toStringAsFixed(2),
    //                       textScaleFactor: 2.3,
    //                       style: TextStyle(
    //                           color: Colors.blue, fontWeight: FontWeight.bold),
    //                     ),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text('Income',
    //                       // AppLocalizations.of(context).translate("income"),
    //                       textScaleFactor: 1.2,
    //                       // style: TextStyle(),
    //                     )
    //                   ],
    //                 ),
    //                 Column(
    //                   children: [
    //                     Text(
    //                       "\$" + state.report.expense.toStringAsFixed(2),
    //                       textScaleFactor: 1.8,
    //                       style: TextStyle(
    //                           color: Colors.red, fontWeight: FontWeight.bold),
    //                     ),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text('Expense',
    //                       // AppLocalizations.of(context).translate("expensePay"),
    //                       textScaleFactor: 1.2,
    //                       // style: TextStyle(),
    //                     )
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             SizedBox(height: 40),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Column(
    //                   children: [
    //                     FittedBox(
    //                         child: Text(
    //                       "\$" + state.report.profit.toStringAsFixed(2),
    //                       textScaleFactor: 1.8,
    //                       style: TextStyle(
    //                           color: Colors.green[800],
    //                           fontWeight: FontWeight.bold),
    //                     )),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text('Profit',
    //                       // AppLocalizations.of(context).translate("profit"),
    //                       textScaleFactor: 1.1,
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(width: 30),
    //                 Column(
    //                   children: [
    //                     FittedBox(
    //                         child: Text(
    //                       state.report.sales.toString(),
    //                       textScaleFactor: 1.8,
    //                       style: TextStyle(
    //                           color: Colors.orange[800],
    //                           fontWeight: FontWeight.bold),
    //                     )),
    //                     SizedBox(
    //                       height: 5,
    //                     ),
    //                     Text(
    //                       'saleCount',
    //                       // AppLocalizations.of(context).translate("saleCount"),
    //                       textScaleFactor: 1.1,
    //                     )
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //     // if (state is ErrorFetchedReport) {
    //     //   // errorSnackBar(text: state.error, context: context);
    //     //   return TextButton(
    //     //     child: Text("Retry"),
    //     //     onPressed: () {},
    //     //   );
    //     // }
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
  }

  showPickerDateRange(BuildContext context) {
    String? _startDate;
    String? _endDate;

    final DateFormat formatter = DateFormat('yyyy-MM-dd kk:mm');
    Picker ps = Picker(
        confirm: Text('Confirm'),
        cancel: Text('Concel'),
        // confirmText: AppLocalizations.of(context).translate("confirm"),
        // cancelText: AppLocalizations.of(context).translate("cancel"),
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            // don't have
            // PickerDateTimeType.kYMD
            // PickerDateTimeType.kMDYHM 24 hours
            type: PickerDateTimeType.kMDYHM,
            isNumberMonth: false),
        onConfirm: (Picker picker, List value) {
          _startDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    // kMDYHM_AP 12 hour have 2 option AM and PM

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kMDYHM),
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
            BlocProvider.of<ReportBloc>(context)
                .add(FetchReportStarted(dateRange: "$_startDate/$_endDate"));
            print(_endDate.toString());
            print(_startDate.toString());
          },
          child: Text(PickerLocalizations.of(context).confirmText!))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Date'),
            // title: Text(AppLocalizations.of(context).translate("selectDate")),
            actions: actions,
            content: Container(
              // width: MediaQuery.of(context).size.width / 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Start'),
                  // Text("${AppLocalizations.of(context).translate("begin")}:"),
                  ps.makePicker(),
                  Text('End'),
                  // Text("${AppLocalizations.of(context).translate("end")}:"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }
}
