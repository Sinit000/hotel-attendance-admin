import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';

WorkingDayBloc workingDayBloc = WorkingDayBloc();

class WorkingDay extends StatelessWidget {
  const WorkingDay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Working Day"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addWorkingday);
            }),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final RefreshController _refreshController = RefreshController();
  void initState() {
    super.initState();

    workingDayBloc.add(InitializeWorkingdayStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: workingDayBloc,
        builder: (context, state) {
          if (state is InitializingWorkingDay) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          } else if (state is ErrorFetchingWorkingDay) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            if (workingDayBloc.departmentList.length == 0) {
              return Center(
                child: Text(
                    "${AppLocalizations.of(context)!.translate("no_data")!}"),
              );
            }
            return SmartRefresher(
              onRefresh: () {
                workingDayBloc.add(RefreshWorkingdayStarted());
              },
              onLoading: () {
                workingDayBloc.add(FetchWoringdayStarted());
                _refreshController.loadComplete();
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount: workingDayBloc.departmentList.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(workingDayBloc.departmentList[index]);
                  }),
            );
          }
        },
        listener: (context, state) {
          if (state is FetchedWorkingDay) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfWorkingDayList) {
            _refreshController.loadNoData();
          }
          if (state is AddingWorkingDay) {
            EasyLoading.show(status: "loading....");
          } else if (state is ErrorAddingWorkingDay) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          } else if (state is AddedWorkingDay) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }

  _buildListItem(WorkingDayModel workingDayModel) {
    return Container(
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
                  "${workingDayModel.name}",
                  style: TextStyle(
                    color: Colors.lightBlue,
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
                    "Work Day :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${workingDayModel.workingDay}",
                  style: TextStyle(
                    color: Colors.green,
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
                    "Off day :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                workingDayModel.offDay == null ||
                        workingDayModel.offDay == "null"
                    ? Text("")
                    : Text(
                        "${workingDayModel.offDay}",
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
                    "Notes :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                workingDayModel.notes == null
                    ? Text("")
                    : Text(
                        "${workingDayModel.notes}",
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
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, editWorkingday,
                          arguments: workingDayModel);
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
                      deleteDialog(
                          context: context,
                          onPress: () {
                            Navigator.pop(context);
                            print("id ${workingDayModel.id}");
                            workingDayBloc.add(DeleteWorkingdayStarted(
                                id: workingDayModel.id));
                          });
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
