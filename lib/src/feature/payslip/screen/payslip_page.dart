import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/model/monthly_model.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/screen/add_payslip.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/screen/payslip_component.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/screen/payslip_list_monthly.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PaySlippage extends StatefulWidget {
  // const PaySlippage({Key? key}) : super(key: key);
  @override
  State<PaySlippage> createState() => _PaySlippageState();
}

class _PaySlippageState extends State<PaySlippage> {
  String? year;
  List<MonthlyModel> paylist = [
    MonthlyModel(monthly: "January", value1: "01-01", value2: "01-31"),
    MonthlyModel(monthly: "February", value1: "02-01", value2: "02-28"),
    MonthlyModel(monthly: "March", value1: "03-01", value2: "03-31"),
    MonthlyModel(monthly: "April", value1: "04-01", value2: "04-30"),
    MonthlyModel(monthly: "May", value1: "05-01", value2: "05-31"),
    MonthlyModel(monthly: "June", value1: "06-01", value2: "06-30"),
    MonthlyModel(monthly: "July", value1: "07-01", value2: "07-31"),
    MonthlyModel(monthly: "August", value1: "08-01", value2: "08-31"),
    MonthlyModel(monthly: "September", value1: "09-01", value2: "09-30"),
    MonthlyModel(monthly: "October", value1: "10-01", value2: "10-31"),
    MonthlyModel(monthly: "November", value1: "11-01", value2: "11-30"),
    MonthlyModel(monthly: "December", value1: "12-01", value2: "12-31")
  ];

  List<String> numMonth = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  String d = "";
  @override
  void initState() {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
    String creDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
    d = creDate.substring(0, 4);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      // floatingActionButton: Container(
      //   child: FloatingActionButton(
      //       backgroundColor: Colors.blue,
      //       child: Icon(Icons.add),
      //       elevation: 0,
      //       onPressed: () {
      //         // Navigator.pushNamed(context, addPayslip);
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => AddPayslip(monthly: "monthly")));
      //       }),
      // ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      elevation: 0,
      backgroundColor: Colors.blue,
      title: Text(
        "Payslip",
        textScaleFactor: 1.1,
      ),
      actions: [
        InkWell(
          onTap: () {
            print('goto');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PayslipComponent()));
          },
          child: Icon(
            Icons.library_books_outlined,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  _buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 10, top: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: DropdownButton<String>(
              hint: Text(
                // leaveBloc.dateRange!,
                // _reportBloc.dateRange!.contains("to")
                //     ? _reportBloc.dateRange!
                //     :W
                "This year",
                textScaleFactor: 1,
              ),
              items: ['Last year', 'This year', 'Next year', "Custom"]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                // if (value == "Custom") {
                //   showPickerDateRange(context);
                // } else {
                //   setState(() {
                //     mydateRage = value!;
                //     print("myvalue $mydateRage");
                //     print(mydateRage);
                //   });
                //   print(value);
                //   overtimeBloc.add(InitializeAllOvertimeStarted(
                //       dateRange: value));
                // }
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 10,
            color: Colors.transparent,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: paylist.length,
                itemBuilder: (con, index) {
                  return InkWell(
                    onTap: () {
                      print("month ${paylist[index]}");
                      String newYear = d +
                          "-" +
                          paylist[index].value1 +
                          "/" +
                          d +
                          "-" +
                          paylist[index].value2;
                      print("new year");
                      print(newYear);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (conxtex) => PayslipListMonthly(
                                  month: paylist[index].value1,
                                  year: d,
                                  dateRange: newYear)));
                    },
                    child: Container(
                      // margin: EdgeInsets.only(top: 10),
                      // color: Colors.redAccent,
                      height: 90,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                // padding: EdgeInsets.only(left: 10),
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(50),

                                  // image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: AssetImage(
                                  //       "${paylist[index].image}",
                                  //     ))
                                ),
                                child: Center(
                                  child: Text(
                                    "${numMonth[index]}".toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor: 1.5,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${paylist[index].monthly}",
                                    textScaleFactor: 1.2,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Text(
                                      "${paylist[index].value1}/${paylist[index].value2}",
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(top: 3),
                                  //   child: Text(
                                  //     "\$1200",
                                  //     style: TextStyle(color: Colors.redAccent),
                                  //   ),
                                  // )
                                ],
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              // InkWell(
                              //   child: Icon(Icons.navigate_next),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            height: 3,
                            // color: Colors.blueAccent,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class PayslipBody extends StatefulWidget {
  const PayslipBody({Key? key}) : super(key: key);

  @override
  State<PayslipBody> createState() => _PayslipBodyState();
}

class _PayslipBodyState extends State<PayslipBody> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
