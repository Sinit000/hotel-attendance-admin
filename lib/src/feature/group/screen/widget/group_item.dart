import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/department_by_group_page.dart';
import 'package:hotle_attendnce_admin/src/feature/group/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/group/model/group_model.dart';
import 'package:hotle_attendnce_admin/src/feature/group/screen/group_page.dart';

Widget groupItem(
    {required BuildContext context, required GroupModel groupModel}) {
  return InkWell(
    onTap: () {
     
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  DepartmentByGroupPage(groupModel: groupModel)));
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "Name :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${groupModel.name}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "Working day :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${groupModel.workingDayModel!.workingDay}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              // mainAxisAlignment:
              //     MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    "Off Day :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${groupModel.workingDayModel!.offDay}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                    padding: EdgeInsets.all(1.0),
                    color: Colors.green,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                      ],
                    ),
                    onPressed: () {
                       Navigator.pushNamed(context, editGroup,arguments: groupModel);
                    }),
                SizedBox(
                  width: 5,
                ),
                CupertinoButton(
                    padding: EdgeInsets.all(1.0),
                    color: Colors.red,
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                      ],
                    ),
                    onPressed: () {
                      print("id ${groupModel.id}");
                      groupBloc.add(DeleteGroupStarted(id: groupModel.id));
                    }),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
