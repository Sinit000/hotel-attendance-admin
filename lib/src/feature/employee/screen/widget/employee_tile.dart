import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';

import '../employee_detail_page.dart';

Widget customerTile({required EmployeeModel? employeeModel}) {
  return Builder(
    builder: (context) {
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
              //         builder: (context) =>
              //             EmployeeDetailPage(employeeModel: employeeModel!)));
            },
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[300]),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
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
                            employeeModel!.name,
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          // AspectRatio(aspectRatio: 1)
                        ],
                      ),
                      SizedBox(height: 10),
                      employeeModel.phone == null
                          ? Text("")
                          : Text(
                              employeeModel.phone!,
                              style: Theme.of(context).textTheme.subtitle2,
                              textAlign: TextAlign.right,
                            ),
                      SizedBox(height: 10),

                      // Text(
                      //         ": ${customer.balance}",
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .subtitle2!
                      //             .copyWith(color: Colors.orange[700]),
                      //         textAlign: TextAlign.right,
                      //       ),
                      // customer.point == null ||
                      //         customer.point == "null" ||
                      //         (customer.point == "0")
                      //     ? Center()
                      //     : Container(
                      //         margin: EdgeInsets.only(top: 10),
                      //         child: Text(
                      //           "${AppLocalizations.of(context)!.translate("point")!} : ${customer.point}",
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .subtitle2!
                      //               .copyWith(color: Colors.purple[700]),
                      //           textAlign: TextAlign.right,
                      //         ),
                      //       ),
                    ],
                  ),
                ),
                CupertinoButton(
                    padding: EdgeInsets.all(1.0),
                    color: Colors.green,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (con) => EditEmployee(
                      //               employeeModel: BlocProvider
                      //                       .of<EmployeeBloc>(
                      //                           context)
                      //                   .emploList[index],
                      //             )));
                    }),
              ],
            )),
      );
    },
  );
}
