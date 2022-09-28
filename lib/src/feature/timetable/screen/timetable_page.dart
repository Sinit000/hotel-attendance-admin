import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/timetable_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';
import 'edit_timetable.dart';

TimetableBloc timetableBloc = TimetableBloc();

class TimetablePage extends StatefulWidget {
  const TimetablePage({Key? key}) : super(key: key);

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("timetable")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: DepartmentBody()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addTimetable);
            }),
      ),
    );
  }
}

class DepartmentBody extends StatefulWidget {
  const DepartmentBody({Key? key}) : super(key: key);

  @override
  State<DepartmentBody> createState() => _DepartmentBodyState();
}

class _DepartmentBodyState extends State<DepartmentBody> {
  final RefreshController _refreshController = RefreshController();
  void initState() {
    super.initState();

    timetableBloc.add(InitializeTimetableStarted());
  }

  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());

    return BlocConsumer(
        bloc: timetableBloc,
        builder: (context, state) {
          if (state is InitializingTimetable) {
            return Center(
              // child: CircularProgressIndicator(),
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          } else if (state is ErrorFetchingTimetable) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            if (timetableBloc.timetableList.length == 0) {
              return Center(
                child: Text(
                    "${AppLocalizations.of(context)!.translate("no_data")!}"),
              );
            }
            return SmartRefresher(
              onRefresh: () {
                timetableBloc.add(RefreshTimetableStarted());
              },
              onLoading: () {
                timetableBloc.add(FetchTimetableStarted());
                _refreshController.loadComplete();
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount: timetableBloc.timetableList.length,
                  itemBuilder: (context, index) {
                    return _buildListItem(timetableBloc.timetableList[index]);
                  }),
            );
          }
        },
        listener: (context, state) {
          if (state is FetchedTimetable) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfTimetableList) {
            _refreshController.loadNoData();
          }
          if (state is AddingTimetable) {
            EasyLoading.show(status: "loading....");
          } else if (state is ErrorAddingTimetable) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          } else if (state is AddedTimetable) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }

  _buildListItem(TimetableModel timetableModel) {
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
                    "${AppLocalizations.of(context)!.translate("name")!} :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${timetableModel.timetableName}",
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
                    "${AppLocalizations.of(context)!.translate("time_in")!} :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${timetableModel.onDutyTtime}",
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
                    "${AppLocalizations.of(context)!.translate("time_out")!} :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${timetableModel.offDutyTime}",
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
                    "${AppLocalizations.of(context)!.translate("late_minute")!} :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${timetableModel.lateMn}",
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
                    "${AppLocalizations.of(context)!.translate("early_leave")!} :",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Text(
                  "${timetableModel.earlyMn}",
                  style: TextStyle(
                    color: Colors.lightBlue,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (con) => EditTimetable(
                                    timetableModel: timetableModel,
                                  )));
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
                            print("id ${timetableModel.id}");
                            timetableBloc.add(
                                DeleteTimetableStarted(id: timetableModel.id));
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
